package com.lioilsources.the_pill

import android.inputmethodservice.InputMethodService
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.TypedValue
import android.view.Gravity
import android.view.KeyEvent
import android.view.View
import android.view.ViewGroup
import android.view.inputmethod.EditorInfo
import android.view.inputmethod.ExtractedTextRequest
import android.view.inputmethod.InputMethodManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import java.util.concurrent.Executors

/**
 * Klávesnice The Pill: česká QWERTZ + lišta kouče.
 * Po pauze v psaní pošle rozepsanou zprávu na /coach; při útoku ukáže lištu.
 * Text nahradí JEN po tapnutí na alternativu — nikdy sama nic neodesílá ani nepřepisuje.
 */
class PillKeyboardService : InputMethodService() {
    private val main = Handler(Looper.getMainLooper())
    private val io = Executors.newSingleThreadExecutor()
    private val gate = CoachGate()
    private var sensitive = false
    private var shift = false
    private var generation = 0 // zahodí odpovědi na starý text

    private lateinit var coachBar: LinearLayout
    private lateinit var coachText: TextView
    private lateinit var altPanel: LinearLayout
    private val letterKeys = mutableListOf<Button>()

    private val checkRunnable = Runnable { maybeCheck() }

    override fun onCreateInputView(): View {
        letterKeys.clear()
        val root = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            setPadding(dp(2), dp(4), dp(2), dp(4))
        }
        root.addView(buildCoachBar())
        root.addView(buildAltPanel())
        ROWS.forEach { root.addView(letterRow(it)) }
        root.addView(shiftRow())
        root.addView(bottomRow())
        return root
    }

    override fun onStartInputView(info: EditorInfo?, restarting: Boolean) {
        super.onStartInputView(info, restarting)
        sensitive = info?.let { CoachGate.isSensitive(it.inputType, it.imeOptions) } ?: true
        gate.reset()
        hideCoach()
    }

    override fun onDestroy() {
        io.shutdownNow()
        super.onDestroy()
    }

    // ---------- psaní ----------

    private fun type(s: String) {
        val out = if (shift) s.uppercase() else s
        currentInputConnection?.commitText(out, 1)
        if (shift) setShift(false)
        afterEdit()
    }

    private fun backspace() {
        currentInputConnection?.let {
            it.sendKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, KeyEvent.KEYCODE_DEL))
            it.sendKeyEvent(KeyEvent(KeyEvent.ACTION_UP, KeyEvent.KEYCODE_DEL))
        }
        afterEdit()
    }

    private fun enter() {
        val ei = currentInputEditorInfo
        val action = ei?.imeOptions?.and(EditorInfo.IME_MASK_ACTION) ?: EditorInfo.IME_ACTION_NONE
        val noEnterAction = ei != null && ei.imeOptions and EditorInfo.IME_FLAG_NO_ENTER_ACTION != 0
        if (!noEnterAction && action != EditorInfo.IME_ACTION_NONE && action != EditorInfo.IME_ACTION_UNSPECIFIED) {
            currentInputConnection?.performEditorAction(action)
        } else {
            type("\n")
        }
    }

    private fun afterEdit() {
        hideCoach()
        generation++
        main.removeCallbacks(checkRunnable)
        main.postDelayed(checkRunnable, CoachGate.DEBOUNCE_MS)
    }

    private fun currentText(): String {
        val ic = currentInputConnection ?: return ""
        ic.getExtractedText(ExtractedTextRequest(), 0)?.text?.let { return it.toString() }
        return ic.getTextBeforeCursor(MAX_CHARS, 0)?.toString() ?: ""
    }

    // ---------- kouč ----------

    private fun maybeCheck() {
        val prefs = SharedConfig.prefs(this)
        val url = prefs.getString(SharedConfig.KEY_SERVER_URL, "") ?: ""
        val enabled = prefs.getBoolean(SharedConfig.KEY_COACH_ENABLED, true)
        val token = prefs.getString(SharedConfig.KEY_TOKEN, "") ?: ""
        val text = currentText()
        if (!gate.shouldCheck(text, enabled, url, sensitive)) return
        gate.markChecked(text)
        val gen = generation
        io.execute {
            val c = CoachClient.coach(url, text.take(MAX_CHARS), token)
            main.post {
                // Uživatel mezitím psal dál → odpověď je k jinému textu, zahodit.
                if (gen == generation && c != null && c.isHostile) showCoach(c)
            }
        }
    }

    private fun showCoach(c: Coaching) {
        coachText.text = getString(R.string.coach_warning)
        coachBar.visibility = View.VISIBLE
        altPanel.removeAllViews()
        if (c.why.isNotBlank()) {
            altPanel.addView(TextView(this).apply {
                text = c.why
                setPadding(dp(8), dp(4), dp(8), dp(4))
            })
        }
        c.alternatives.forEach { alt ->
            altPanel.addView(Button(this).apply {
                text = alt
                isAllCaps = false
                gravity = Gravity.START or Gravity.CENTER_VERTICAL
                setOnClickListener { replaceWith(alt) }
            })
        }
        altPanel.visibility = View.GONE
    }

    private fun hideCoach() {
        if (!::coachBar.isInitialized) return
        coachBar.visibility = View.GONE
        altPanel.visibility = View.GONE
    }

    /** Nahradí celý rozepsaný text vybranou alternativou — jen na výslovné tapnutí. */
    private fun replaceWith(alt: String) {
        val ic = currentInputConnection ?: return
        val len = currentText().length
        ic.beginBatchEdit()
        ic.setSelection(0, len)
        ic.commitText(alt, 1)
        ic.endBatchEdit()
        gate.markChecked(alt)
        hideCoach()
    }

    // ---------- UI ----------

    private fun buildCoachBar(): LinearLayout {
        coachText = TextView(this).apply {
            layoutParams = LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.WRAP_CONTENT, 1f)
            setPadding(dp(8), 0, dp(8), 0)
        }
        val show = Button(this).apply {
            text = getString(R.string.coach_show)
            isAllCaps = false
            setOnClickListener { altPanel.visibility = View.VISIBLE }
        }
        val dismiss = Button(this).apply {
            text = getString(R.string.coach_dismiss)
            isAllCaps = false
            setOnClickListener { hideCoach() }
        }
        coachBar = LinearLayout(this).apply {
            orientation = LinearLayout.HORIZONTAL
            gravity = Gravity.CENTER_VERTICAL
            visibility = View.GONE
            addView(coachText)
            addView(show)
            addView(dismiss)
        }
        return coachBar
    }

    private fun buildAltPanel(): LinearLayout {
        altPanel = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            visibility = View.GONE
        }
        return altPanel
    }

    private fun row(): LinearLayout = LinearLayout(this).apply {
        orientation = LinearLayout.HORIZONTAL
        layoutParams = LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, dp(48))
    }

    private fun key(label: String, weight: Float = 1f, onTap: () -> Unit): Button = Button(this).apply {
        text = label
        isAllCaps = false
        minWidth = 0
        minimumWidth = 0
        setPadding(0, 0, 0, 0)
        setTextSize(TypedValue.COMPLEX_UNIT_SP, 17f)
        layoutParams = LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.MATCH_PARENT, weight)
        setOnClickListener { onTap() }
    }

    private fun letterRow(chars: String): LinearLayout = row().apply {
        chars.forEach { ch ->
            val b = key(ch.toString()) { type(ch.toString()) }
            if (ch.isLetter()) letterKeys += b
            addView(b)
        }
    }

    private fun shiftRow(): LinearLayout = row().apply {
        addView(key("⇧", 1.5f) { setShift(!shift) })
        "yxcvbnm".forEach { ch ->
            val b = key(ch.toString()) { type(ch.toString()) }
            letterKeys += b
            addView(b)
        }
        addView(key("⌫", 1.5f) { backspace() })
    }

    private fun bottomRow(): LinearLayout = row().apply {
        addView(key("🌐", 1.2f) { switchKeyboard() })
        addView(key(",") { type(",") })
        addView(key(getString(R.string.key_space), 4f) { type(" ") })
        addView(key(".") { type(".") })
        addView(key("?") { type("?") })
        addView(key("↵", 1.5f) { enter() })
    }

    private fun setShift(on: Boolean) {
        shift = on
        letterKeys.forEach { b ->
            val s = b.text.toString()
            b.text = if (on) s.uppercase() else s.lowercase()
        }
    }

    private fun switchKeyboard() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P && switchToPreviousInputMethod()) return
        (getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager).showInputMethodPicker()
    }

    private fun dp(v: Int): Int =
        TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, v.toFloat(), resources.displayMetrics).toInt()

    companion object {
        const val MAX_CHARS = 2000

        // Čeština: čísla (časy, částky), diakritika, QWERTZ. Dlouhý stisk pro ň/ť/ď/ó zatím ne.
        val ROWS = listOf("1234567890", "ěščřžýáíéůú", "qwertzuiop", "asdfghjkl")
    }
}

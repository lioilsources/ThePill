package com.lioilsources.the_pill

import android.text.InputType
import android.view.inputmethod.EditorInfo

/**
 * Kdy kouče volat. Čistá logika bez Android závislostí kromě konstant — testuje se JUnitem.
 * Pravidla: kouč zapnutý, adresa serveru vyplněná, pole není citlivé, text má aspoň
 * MIN_CHARS znaků a od poslední kontroly se změnil.
 */
class CoachGate(private val minChars: Int = MIN_CHARS) {
    private var lastChecked: String? = null

    fun shouldCheck(text: String, enabled: Boolean, serverUrl: String, sensitive: Boolean): Boolean {
        if (!enabled || sensitive || serverUrl.isBlank()) return false
        val t = text.trim()
        if (t.length < minChars) return false
        return t != lastChecked
    }

    fun markChecked(text: String) {
        lastChecked = text.trim()
    }

    fun reset() {
        lastChecked = null
    }

    companion object {
        const val MIN_CHARS = 12
        const val DEBOUNCE_MS = 1200L

        /** Hesla, PINy, čísla, telefony, e-maily a anonymní režim se nikdy neposílají. */
        fun isSensitive(inputType: Int, imeOptions: Int): Boolean {
            val cls = inputType and InputType.TYPE_MASK_CLASS
            val variation = inputType and InputType.TYPE_MASK_VARIATION
            if (cls == InputType.TYPE_CLASS_NUMBER || cls == InputType.TYPE_CLASS_PHONE ||
                cls == InputType.TYPE_CLASS_DATETIME
            ) return true
            if (cls == InputType.TYPE_CLASS_TEXT && variation in setOf(
                    InputType.TYPE_TEXT_VARIATION_PASSWORD,
                    InputType.TYPE_TEXT_VARIATION_VISIBLE_PASSWORD,
                    InputType.TYPE_TEXT_VARIATION_WEB_PASSWORD,
                    InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS,
                    InputType.TYPE_TEXT_VARIATION_WEB_EMAIL_ADDRESS,
                    InputType.TYPE_TEXT_VARIATION_URI,
                )
            ) return true
            return imeOptions and EditorInfo.IME_FLAG_NO_PERSONALIZED_LEARNING != 0
        }
    }
}

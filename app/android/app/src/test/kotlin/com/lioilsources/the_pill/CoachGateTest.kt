package com.lioilsources.the_pill

import android.text.InputType
import android.view.inputmethod.EditorInfo
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class CoachGateTest {
    private val url = "http://pill.test:8090"

    @Test
    fun checksOnlyChangedLongEnoughText() {
        val g = CoachGate()
        assertFalse(g.shouldCheck("krátké", true, url, false))
        assertTrue(g.shouldCheck("KDE SAKRA JSOU KLÍČE", true, url, false))
        g.markChecked("KDE SAKRA JSOU KLÍČE")
        assertFalse(g.shouldCheck("KDE SAKRA JSOU KLÍČE ", true, url, false))
        assertTrue(g.shouldCheck("KDE SAKRA JSOU KLÍČE OD AUTA", true, url, false))
    }

    @Test
    fun neverChecksWhenDisabledSensitiveOrNoServer() {
        val g = CoachGate()
        val t = "KDE SAKRA JSOU KLÍČE"
        assertFalse(g.shouldCheck(t, false, url, false))
        assertFalse(g.shouldCheck(t, true, "", false))
        assertFalse(g.shouldCheck(t, true, url, true))
    }

    @Test
    fun sensitiveFields() {
        val text = InputType.TYPE_CLASS_TEXT
        assertTrue(CoachGate.isSensitive(text or InputType.TYPE_TEXT_VARIATION_PASSWORD, 0))
        assertTrue(CoachGate.isSensitive(InputType.TYPE_CLASS_NUMBER, 0))
        assertTrue(CoachGate.isSensitive(InputType.TYPE_CLASS_PHONE, 0))
        assertTrue(CoachGate.isSensitive(text, EditorInfo.IME_FLAG_NO_PERSONALIZED_LEARNING))
        assertFalse(CoachGate.isSensitive(text or InputType.TYPE_TEXT_FLAG_MULTI_LINE, 0))
    }
}

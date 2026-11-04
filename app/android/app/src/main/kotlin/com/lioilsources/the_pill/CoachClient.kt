package com.lioilsources.the_pill

import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL

data class Coaching(val isHostile: Boolean, val why: String, val alternatives: List<String>)

/** POST /coach na pill-core. Fail-open: jakákoli chyba = null (kouč mlčí). Volat mimo hlavní vlákno. */
object CoachClient {
    fun coach(serverUrl: String, text: String, lang: String = "cs"): Coaching? = try {
        val conn = URL(serverUrl.trimEnd('/') + "/coach").openConnection() as HttpURLConnection
        conn.requestMethod = "POST"
        conn.connectTimeout = 4000
        conn.readTimeout = 8000
        conn.doOutput = true
        conn.setRequestProperty("Content-Type", "application/json; charset=utf-8")
        val body = JSONObject().put("text", text).put("lang", lang).toString()
        conn.outputStream.use { it.write(body.toByteArray(Charsets.UTF_8)) }
        if (conn.responseCode != 200) {
            conn.disconnect()
            null
        } else {
            val raw = conn.inputStream.use { it.readBytes().toString(Charsets.UTF_8) }
            conn.disconnect()
            parse(raw)
        }
    } catch (e: Exception) {
        null
    }

    fun parse(raw: String): Coaching? {
        val j = JSONObject(raw)
        if (j.optBoolean("degraded", false)) return null
        val arr = j.optJSONArray("alternatives")
        val alts = (0 until (arr?.length() ?: 0)).mapNotNull { arr?.optString(it) }.filter { it.isNotBlank() }.take(2)
        val c = Coaching(j.optBoolean("is_hostile", false), j.optString("why", ""), alts)
        return if (c.isHostile && c.alternatives.isEmpty()) null else c
    }
}

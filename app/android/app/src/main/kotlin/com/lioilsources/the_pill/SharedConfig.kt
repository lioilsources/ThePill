package com.lioilsources.the_pill

import android.content.Context
import android.content.SharedPreferences

/** Stejné klíče jako lib/src/shared_config.dart. */
object SharedConfig {
    const val FILE = "pill_shared"
    const val KEY_SERVER_URL = "server_url"
    const val KEY_COACH_ENABLED = "coach_enabled"

    fun prefs(ctx: Context): SharedPreferences = ctx.getSharedPreferences(FILE, Context.MODE_PRIVATE)
}

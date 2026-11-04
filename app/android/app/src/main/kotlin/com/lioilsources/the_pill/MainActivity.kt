package com.lioilsources.the_pill

import android.content.Intent
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/** Flutter ↔ klávesnice: nastavení v SharedPreferences, které čte PillKeyboardService. */
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "thepill/shared_config")
            .setMethodCallHandler { call, result ->
                val prefs = SharedConfig.prefs(this)
                when (call.method) {
                    "load" -> result.success(
                        mapOf(
                            SharedConfig.KEY_SERVER_URL to prefs.getString(SharedConfig.KEY_SERVER_URL, ""),
                            SharedConfig.KEY_COACH_ENABLED to prefs.getBoolean(SharedConfig.KEY_COACH_ENABLED, true),
                        )
                    )
                    "save" -> {
                        prefs.edit()
                            .putString(SharedConfig.KEY_SERVER_URL, call.argument<String>(SharedConfig.KEY_SERVER_URL) ?: "")
                            .putBoolean(SharedConfig.KEY_COACH_ENABLED, call.argument<Boolean>(SharedConfig.KEY_COACH_ENABLED) ?: true)
                            .apply()
                        result.success(null)
                    }
                    "openKeyboardSettings" -> {
                        startActivity(Intent(Settings.ACTION_INPUT_METHOD_SETTINGS))
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}

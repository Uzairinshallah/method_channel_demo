package com.example.method_channel_code

import android.widget.Toast
import kotlin.random.Random
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Method channel for displaying Toast messages
        val toastChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/toast")
        toastChannel.setMethodCallHandler { call, result ->
            if (call.method == "showToast") {
                val message = call.argument<String>("message")
                showToast(message)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }

        // Method channel for generating random numbers
        val numberChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "example.com/number")
        numberChannel.setMethodCallHandler { call, result ->
            if (call.method == "getRandomNumber") {
                val randomNumber = Random.nextInt(100)
                result.success(randomNumber)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun showToast(message: String?) {

        message?.let {
            Toast.makeText(this, it, Toast.LENGTH_LONG).show()
        }
    }
}

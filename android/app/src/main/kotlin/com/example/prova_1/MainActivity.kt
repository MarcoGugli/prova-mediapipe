package com.example.prova_1

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.nome_app/channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "metodoNativo") {
                val parametro = call.argument<String>("param")
                val risposta = metodoNativo(parametro)
                result.success(risposta)  // Risponde al Dart con il risultato
            } else {
                result.notImplemented()
            }
        }
    }

    private fun metodoNativo(parametro: String?): String {
        // Implementa la logica nativa
        return "Messaggio ricevuto: $parametro"
    }
}

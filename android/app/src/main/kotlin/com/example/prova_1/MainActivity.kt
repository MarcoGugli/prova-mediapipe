package com.example.prova_1

import android.graphics.Bitmap
import android.os.Bundle
import com.google.mediapipe.examples.poselandmarker.ImageDetectionListener
import com.google.mediapipe.examples.poselandmarker.PoseLandmarkerHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.setupWithNavController

class MainActivity: FlutterActivity(), ImageDetectionListener {
    private val CHANNEL = "pose_landmarker_channel"
    private var methodChannel: MethodChannel? = null
    private lateinit var poseLandmarkerHelper: PoseLandmarkerHelper

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // Crea un'istanza di PoseLandmarkerHelper con il listener
        poseLandmarkerHelper = PoseLandmarkerHelper(
            context = this,
            imageDetectionListener = this // Passa il listener
        )

        // Esempio: chiamata alla funzione detectImage
        val sampleBitmap = getSampleBitmap() // Ottieni un Bitmap di esempio
        poseLandmarkerHelper.detectImage(sampleBitmap)
    }

    override fun onPoseDetected(resultBundle: PoseLandmarkerHelper.ResultBundle) {
        methodChannel?.invokeMethod("onPoseDetected", resultBundle)
    }

    override fun onError(error: String) {
        methodChannel?.invokeMethod("onError", error)
    }

    // Funzione per ottenere un Bitmap di esempio
    private fun getSampleBitmap(): Bitmap {
        // Aggiungi qui il codice per caricare un'immagine
        throw NotImplementedError("Implementa la logica per ottenere un Bitmap")
    }

    private fun metodoNativo(parametro: String?): String {
        // Implementa la logica nativa
        return "Messaggio ricevuto: $parametro"
    }
}

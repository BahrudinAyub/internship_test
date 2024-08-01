package com.example.internship_test

import android.os.Build
import android.media.MediaMetadataRetriever
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileOutputStream

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.deviceinfo/info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getDeviceInfo" -> {
                    val deviceInfo = "Device: ${Build.DEVICE}, OS Version: ${Build.VERSION.RELEASE}"
                    result.success(deviceInfo)
                }
                "getVideoInfo" -> {
                    try {
                        // Membuka file video dari assets
                        val assetManager = assets
                        val inputStream = assetManager.open("videos/sample_video.mp4")

                        // Menyalin file video ke cacheDir agar bisa diakses oleh MediaMetadataRetriever
                        val file = File(cacheDir, "sample_video.mp4")
                        val outputStream = FileOutputStream(file)
                        inputStream.copyTo(outputStream)
                        outputStream.close()
                        inputStream.close()

                        // Logging untuk memastikan file berhasil disalin
                        Log.d("MainActivity", "Video file path: ${file.absolutePath}")

                        // Mengambil informasi video menggunakan MediaMetadataRetriever
                        val retriever = MediaMetadataRetriever()
                        val fileDescriptor = file.inputStream().fd
                        retriever.setDataSource(fileDescriptor)
                        val duration = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_DURATION)
                        val width = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_WIDTH)
                        val height = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_HEIGHT)
                        val codec = retriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_MIMETYPE)
                        retriever.release()

                        val videoInfo = "Duration: ${duration}ms, Resolution: ${width}x${height}, Codec: $codec"
                        result.success(videoInfo)
                    } catch (e: Exception) {
                        Log.e("MainActivity", "Error retrieving video info", e)
                        result.error("UNAVAILABLE", "Video info not available: ${e.message}", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}

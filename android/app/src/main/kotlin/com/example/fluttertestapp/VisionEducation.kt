package com.example.fluttertestapp
import android.app.Application
import com.resul.refluttersdk.RefluttersdkPlugin

class VisionEducation: Application() {
    override fun onCreate() {
        super.onCreate()
        RefluttersdkPlugin().initReSdk(this)
    }
}
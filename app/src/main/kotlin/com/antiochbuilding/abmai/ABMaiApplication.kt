package com.antiochbuilding.abmai

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

/**
 * Application class for ABM.ai Android.
 * This class is annotated with @HiltAndroidApp to enable dependency injection
 * throughout the application.
 */
@HiltAndroidApp
class ABMaiApplication : Application() {

    override fun onCreate() {
        super.onCreate()
        // Initialize any app-wide services or configurations here
    }
}

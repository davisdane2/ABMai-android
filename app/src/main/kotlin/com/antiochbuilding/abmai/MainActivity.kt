package com.antiochbuilding.abmai

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.antiochbuilding.abmai.ui.screens.DashboardScreen
import com.antiochbuilding.abmai.ui.theme.ABMaiTheme
import dagger.hilt.android.AndroidEntryPoint

/**
 * Main activity for the ABM.ai Android application.
 * This activity serves as the entry point and hosts the Compose UI.
 */
@AndroidEntryPoint
class MainActivity : ComponentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()

        setContent {
            ABMaiTheme {
                Surface(
                    modifier = Modifier.fillMaxSize()
                ) {
                    DashboardScreen()
                }
            }
        }
    }
}

package com.antiochbuilding.abmai.ui.components

import android.graphics.Bitmap
import android.webkit.WebChromeClient
import android.webkit.WebResourceRequest
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalLifecycleOwner
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleEventObserver
import java.io.BufferedReader
import java.io.InputStreamReader

/**
 * Composable that displays a dashboard in a WebView.
 * Loads HTML content from the assets folder and manages lifecycle.
 *
 * @param htmlPath Path to the HTML file in the assets folder
 * @param modifier Modifier for the WebView
 * @param onNavigationStateChanged Callback for navigation state changes (canGoBack, canGoForward)
 */
@Composable
fun DashboardWebView(
    htmlPath: String,
    modifier: Modifier = Modifier,
    onNavigationStateChanged: (canGoBack: Boolean, canGoForward: Boolean) -> Unit = { _, _ -> }
) {
    val context = LocalContext.current
    val lifecycleOwner = LocalLifecycleOwner.current
    var isLoading by remember { mutableStateOf(true) }
    var progress by remember { mutableFloatStateOf(0f) }

    var webView by remember { mutableStateOf<WebView?>(null) }

    // Handle lifecycle events for pause/resume
    DisposableEffect(lifecycleOwner) {
        val observer = LifecycleEventObserver { _, event ->
            when (event) {
                Lifecycle.Event.ON_PAUSE -> {
                    webView?.let { pauseDashboard(it) }
                }
                Lifecycle.Event.ON_RESUME -> {
                    webView?.let { resumeDashboard(it) }
                }
                else -> {}
            }
        }

        lifecycleOwner.lifecycle.addObserver(observer)

        onDispose {
            lifecycleOwner.lifecycle.removeObserver(observer)
            webView?.destroy()
        }
    }

    Box(modifier = modifier.fillMaxSize()) {
        AndroidView(
            factory = { ctx ->
                WebView(ctx).apply {
                    webView = this

                    // Configure WebView settings
                    settings.apply {
                        javaScriptEnabled = true
                        domStorageEnabled = true
                        allowFileAccess = true
                        allowContentAccess = true
                        setSupportZoom(true)
                        builtInZoomControls = true
                        displayZoomControls = false
                        loadWithOverviewMode = true
                        useWideViewPort = true
                    }

                    // Set WebViewClient for page navigation
                    webViewClient = object : WebViewClient() {
                        override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                            super.onPageStarted(view, url, favicon)
                            isLoading = true
                            onNavigationStateChanged(view?.canGoBack() ?: false, view?.canGoForward() ?: false)
                        }

                        override fun onPageFinished(view: WebView?, url: String?) {
                            super.onPageFinished(view, url)
                            isLoading = false
                            onNavigationStateChanged(view?.canGoBack() ?: false, view?.canGoForward() ?: false)

                            // Inject timer tracking script
                            view?.evaluateJavascript(TIMER_TRACKING_SCRIPT, null)
                        }

                        override fun shouldOverrideUrlLoading(
                            view: WebView?,
                            request: WebResourceRequest?
                        ): Boolean {
                            // Handle CHASCO system navigation (open in browser)
                            if (request?.url?.host == "10.52.10.100") {
                                android.content.Intent(android.content.Intent.ACTION_VIEW, request.url)
                                    .also { ctx.startActivity(it) }
                                return true
                            }
                            return false
                        }
                    }

                    // Set WebChromeClient for progress updates
                    webChromeClient = object : WebChromeClient() {
                        override fun onProgressChanged(view: WebView?, newProgress: Int) {
                            super.onProgressChanged(view, newProgress)
                            progress = newProgress / 100f
                        }
                    }

                    // Load HTML from assets
                    loadHtmlFromAssets(this, htmlPath)
                }
            },
            modifier = Modifier.fillMaxSize()
        )

        // Loading progress indicator
        if (isLoading && progress < 1f) {
            LinearProgressIndicator(
                progress = { progress },
                modifier = Modifier
                    .fillMaxWidth()
                    .height(2.dp)
                    .align(Alignment.TopCenter),
                color = MaterialTheme.colorScheme.primary,
                trackColor = MaterialTheme.colorScheme.surfaceVariant,
            )
        }
    }
}

/**
 * Loads HTML content from the assets folder.
 */
private fun loadHtmlFromAssets(webView: WebView, assetPath: String) {
    try {
        val inputStream = webView.context.assets.open(assetPath)
        val bufferedReader = BufferedReader(InputStreamReader(inputStream))
        val htmlContent = bufferedReader.use { it.readText() }

        // Get base URL for loading related resources
        val baseUrl = "file:///android_asset/${assetPath.substringBeforeLast("/")}"

        webView.loadDataWithBaseURL(
            baseUrl,
            htmlContent,
            "text/html",
            "UTF-8",
            null
        )

        android.util.Log.d("DashboardWebView", "Loading dashboard: $assetPath")
    } catch (e: Exception) {
        android.util.Log.e("DashboardWebView", "Error loading HTML from assets", e)
    }
}

/**
 * Pauses the dashboard by clearing all JavaScript timers.
 */
private fun pauseDashboard(webView: WebView) {
    webView.evaluateJavascript(PAUSE_SCRIPT) { result ->
        android.util.Log.d("DashboardWebView", "Dashboard paused")
    }
}

/**
 * Resumes the dashboard and optionally triggers a refresh.
 */
private fun resumeDashboard(webView: WebView) {
    webView.evaluateJavascript(RESUME_SCRIPT) { result ->
        android.util.Log.d("DashboardWebView", "Dashboard resumed")
    }
}

// JavaScript for tracking timers
private const val TIMER_TRACKING_SCRIPT = """
(function() {
    if (!window._originalSetInterval) {
        window._originalSetInterval = window.setInterval;
        window._originalSetTimeout = window.setTimeout;
        window._activeTimers = [];

        window.setInterval = function() {
            const id = window._originalSetInterval.apply(this, arguments);
            window._activeTimers.push(id);
            return id;
        };

        window.setTimeout = function() {
            const id = window._originalSetTimeout.apply(this, arguments);
            window._activeTimers.push(id);
            return id;
        };

        console.log('✅ Timer tracking initialized');
    }
})();
"""

// JavaScript for pausing timers
private const val PAUSE_SCRIPT = """
(function() {
    if (!window._originalSetInterval) {
        window._originalSetInterval = window.setInterval;
        window._originalSetTimeout = window.setTimeout;
        window._originalClearInterval = window.clearInterval;
        window._originalClearTimeout = window.clearTimeout;
        window._activeTimers = [];
    }

    window._activeTimers.forEach(function(id) {
        window._originalClearInterval(id);
        window._originalClearTimeout(id);
    });
    window._activeTimers = [];

    console.log('🛑 Dashboard paused - all timers cleared');
})();
"""

// JavaScript for resuming
private const val RESUME_SCRIPT = """
(function() {
    console.log('▶️ Dashboard resumed - page can create new timers');

    if (typeof window.refreshData === 'function') {
        window.refreshData();
    }
})();
"""

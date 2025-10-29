package com.antiochbuilding.abmai.ui.screens

import android.content.Intent
import android.graphics.BitmapFactory
import android.net.Uri
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.core.LinearEasing
import androidx.compose.animation.core.RepeatMode
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.infiniteRepeatable
import androidx.compose.animation.core.rememberInfiniteTransition
import androidx.compose.animation.core.tween
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInVertically
import androidx.compose.animation.slideOutVertically
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowBack
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.Badge
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Snackbar
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.blur
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.antiochbuilding.abmai.data.models.Dashboard
import com.antiochbuilding.abmai.data.models.DashboardCategory
import com.antiochbuilding.abmai.data.models.DashboardRepository
import com.antiochbuilding.abmai.data.models.getAppVersion
import com.antiochbuilding.abmai.ui.components.DashboardWebView
import com.antiochbuilding.abmai.ui.theme.GlassBackground
import com.antiochbuilding.abmai.ui.theme.GlassStroke
import com.antiochbuilding.abmai.ui.theme.GradientEnd
import com.antiochbuilding.abmai.ui.theme.GradientMiddle
import com.antiochbuilding.abmai.ui.theme.GradientStart
import kotlinx.coroutines.delay
import java.io.InputStream

/**
 * Main dashboard screen showing categories and dashboard cards.
 */
@Composable
fun DashboardScreen() {
    var selectedDashboard by remember { mutableStateOf<Dashboard?>(null) }
    val snackbarHostState = remember { SnackbarHostState() }

    Box(modifier = Modifier.fillMaxSize()) {
        if (selectedDashboard == null) {
            DashboardListScreen(
                onDashboardClick = { dashboard ->
                    selectedDashboard = dashboard
                },
                snackbarHostState = snackbarHostState
            )
        } else {
            DashboardDetailScreen(
                dashboard = selectedDashboard!!,
                onBack = { selectedDashboard = null }
            )
        }
    }
}

/**
 * List of dashboard categories with horizontal scrolling cards.
 */
@Composable
private fun DashboardListScreen(
    onDashboardClick: (Dashboard) -> Unit,
    snackbarHostState: SnackbarHostState
) {
    Box(modifier = Modifier.fillMaxSize()) {
        // Animated gradient background
        AnimatedGradientBackground()

        // Content
        LazyColumn(
            modifier = Modifier.fillMaxSize(),
            contentPadding = PaddingValues(bottom = 40.dp)
        ) {
            // Header
            item {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(top = 60.dp, bottom = 20.dp),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text(
                        text = "ABM.ai",
                        fontSize = 52.sp,
                        fontWeight = FontWeight.Bold,
                        color = Color.White,
                        style = MaterialTheme.typography.displayLarge.copy(
                            brush = Brush.linearGradient(
                                colors = listOf(Color.White, Color.White.copy(alpha = 0.8f))
                            )
                        )
                    )
                    Text(
                        text = "dashboards",
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color.White.copy(alpha = 0.9f)
                    )
                    Spacer(modifier = Modifier.height(12.dp))
                    val context = LocalContext.current
                    val openUrl = { url: String ->
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                        context.startActivity(intent)
                    }
                    Text(
                        text = "View on web",
                        fontSize = 14.sp,
                        fontWeight = FontWeight.Medium,
                        color = Color.White.copy(alpha = 0.9f),
                        modifier = Modifier.clickable { openUrl("https://www.antiochbuilding.com/dashboard") }
                    )
                }
            }

            // Global update badge
            val context = LocalContext.current
            val (versionName, _) = getAppVersion(context)
            val globalUpdateVersion = "1.72"
            val globalUpdateMessage = "New in v1.72 - all dashboards re-factored and some may launch externally in Safari while being integrated"
            if (versionName == globalUpdateVersion) {
                item {
                    GlobalUpdateBadge(message = globalUpdateMessage)
                }
            }

            // Categories
            DashboardCategory.entries.forEach { category ->
                item {
                    CategorySection(
                        category = category,
                        onDashboardClick = onDashboardClick
                    )
                }
            }
        }

        // Snackbar for welcome message
        SnackbarHost(
            hostState = snackbarHostState,
            modifier = Modifier
                .align(Alignment.BottomCenter)
                .padding(bottom = 100.dp)
        ) { data ->
            GlassmorphicSnackbar(message = data.visuals.message)
        }
    }

    // Show welcome message on first load
    LaunchedEffect(Unit) {
        delay(500)
        snackbarHostState.showSnackbar("Welcome to ABM.ai Dashboards!")
    }
}

/**
 * Category section with title and horizontal scrolling dashboard cards.
 */
@Composable
private fun CategorySection(
    category: DashboardCategory,
    onDashboardClick: (Dashboard) -> Unit
) {
    Column {
        // Category title
        Text(
            text = category.displayName,
            fontSize = 24.sp,
            fontWeight = FontWeight.Bold,
            color = Color.White,
            modifier = Modifier.padding(
                top = 20.dp,
                bottom = 12.dp,
                start = 20.dp
            )
        )

        // Dashboard cards
        LazyRow(
            contentPadding = PaddingValues(horizontal = 20.dp),
            horizontalArrangement = Arrangement.spacedBy(16.dp)
        ) {
            items(DashboardRepository.getDashboardsByCategory(category)) { dashboard ->
                DashboardCard(
                    dashboard = dashboard,
                    onClick = { onDashboardClick(dashboard) }
                )
            }
        }
    }
}

/**
 * Dashboard icon that displays either an emoji or a PNG logo from assets.
 */
@Composable
private fun DashboardIcon(
    iconName: String,
    modifier: Modifier = Modifier
) {
    val context = LocalContext.current

    // Check if it's a PNG file
    if (iconName.endsWith(".png", ignoreCase = true)) {
        // Load image from assets
        val bitmap = remember(iconName) {
            try {
                val inputStream: InputStream = context.assets.open("dashboards/Dashboardlogos/$iconName")
                BitmapFactory.decodeStream(inputStream)?.asImageBitmap()
            } catch (e: Exception) {
                e.printStackTrace()
                null
            }
        }

        if (bitmap != null) {
            Image(
                bitmap = bitmap,
                contentDescription = "Dashboard logo",
                modifier = modifier,
                contentScale = ContentScale.Fit
            )
        } else {
            // Fallback to default emoji if image fails to load
            Text(
                text = "📊",
                fontSize = 40.sp,
                modifier = modifier
            )
        }
    } else {
        // Display as emoji
        Text(
            text = iconName.takeIf { it.isNotEmpty() } ?: "📊",
            fontSize = 40.sp,
            modifier = modifier
        )
    }
}

/**
 * Glassmorphic dashboard card.
 */
@Composable
private fun DashboardCard(
    dashboard: Dashboard,
    onClick: () -> Unit
) {
    val context = LocalContext.current
    val openUrl = { url: String ->
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        context.startActivity(intent)
    }

    Card(
        modifier = Modifier
            .size(width = 180.dp, height = 160.dp)
            .clickable {
                if (dashboard.openInSafari) {
                    openUrl(dashboard.htmlPath)
                } else {
                    onClick()
                }
            },
        shape = RoundedCornerShape(20.dp),
        colors = CardDefaults.cardColors(
            containerColor = GlassBackground
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = 8.dp
        )
    ) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(
                    brush = Brush.linearGradient(
                        colors = listOf(
                            Color.White.copy(alpha = 0.2f),
                            Color.White.copy(alpha = 0.05f)
                        )
                    )
                )
                .padding(16.dp)
        ) {
            Column(
                modifier = Modifier.fillMaxSize(),
                verticalArrangement = Arrangement.SpaceBetween
            ) {
                // Icon - either emoji or PNG logo
                DashboardIcon(
                    iconName = dashboard.icon,
                    modifier = Modifier
                        .size(60.dp)
                        .padding(top = 8.dp)
                )

                // Name and description
                Column {
                    Text(
                        text = dashboard.name,
                        fontSize = 16.sp,
                        fontWeight = FontWeight.SemiBold,
                        color = Color.White,
                        maxLines = 2,
                        overflow = TextOverflow.Ellipsis
                    )
                    Spacer(modifier = Modifier.height(4.dp))
                    Text(
                        text = dashboard.description,
                        fontSize = 12.sp,
                        color = Color.White.copy(alpha = 0.7f),
                        maxLines = 2,
                        overflow = TextOverflow.Ellipsis
                    )
                }
            }

            // "Recently Updated" badge
            if (dashboard.showRecentlyUpdatedBadge(context)) {
                Badge(
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .padding(4.dp),
                    containerColor = MaterialTheme.colorScheme.primary
                ) {
                    Text(
                        text = "New",
                        color = Color.White,
                        fontSize = 10.sp,
                        fontWeight = FontWeight.Bold
                    )
                }
            }
        }
    }
}

/**
 * Dashboard detail screen with WebView.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
private fun DashboardDetailScreen(
    dashboard: Dashboard,
    onBack: () -> Unit
) {
    var canGoBack by remember { mutableStateOf(false) }
    var canGoForward by remember { mutableStateOf(false) }
    var webView by remember { mutableStateOf<android.webkit.WebView?>(null) }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        text = dashboard.name,
                        color = Color.White
                    )
                },
                navigationIcon = {
                    IconButton(onClick = onBack) {
                        Icon(
                            imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                            contentDescription = "Back",
                            tint = Color.White
                        )
                    }
                },
                actions = {
                    if (canGoBack || canGoForward) {
                        IconButton(
                            onClick = { webView?.reload() }
                        ) {
                            Icon(
                                imageVector = Icons.Default.Refresh,
                                contentDescription = "Refresh",
                                tint = Color.White
                            )
                        }
                    }
                },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = Color(0xFF1A1A4D)
                )
            )
        }
    ) { paddingValues ->
        // Use native Compose for CHASCOmobile, WebView for others
        if (dashboard.name == "CHASCOmobile") {
            CHASCOmobileScreen()
        } else {
            DashboardWebView(
                htmlPath = dashboard.htmlPath,
                modifier = Modifier.padding(paddingValues),
                onNavigationStateChanged = { back, forward ->
                    canGoBack = back
                    canGoForward = forward
                }
            )
        }
    }
}

/**
 * Animated gradient background with floating circles.
 */
@Composable
private fun AnimatedGradientBackground() {
    val infiniteTransition = rememberInfiniteTransition(label = "background")

    val offset1 by infiniteTransition.animateFloat(
        initialValue = 0f,
        targetValue = 1f,
        animationSpec = infiniteRepeatable(
            animation = tween(5000, easing = LinearEasing),
            repeatMode = RepeatMode.Reverse
        ),
        label = "offset1"
    )

    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(
                brush = Brush.linearGradient(
                    colors = listOf(GradientStart, GradientMiddle, GradientEnd),
                    start = Offset(0f, 0f),
                    end = Offset(1000f, 1000f)
                )
            )
    ) {
        // Floating circles
        Canvas(modifier = Modifier.fillMaxSize()) {
            val circleRadius = 100.dp.toPx()

            // Circle 1
            drawCircle(
                brush = Brush.radialGradient(
                    colors = listOf(
                        Color.White.copy(alpha = 0.1f),
                        Color.Transparent
                    ),
                    center = Offset(size.width * 0.2f, size.height * (0.3f + offset1 * 0.2f)),
                    radius = circleRadius
                ),
                radius = circleRadius,
                center = Offset(size.width * 0.2f, size.height * (0.3f + offset1 * 0.2f))
            )

            // Circle 2
            drawCircle(
                brush = Brush.radialGradient(
                    colors = listOf(
                        Color.White.copy(alpha = 0.1f),
                        Color.Transparent
                    ),
                    center = Offset(size.width * 0.7f, size.height * (0.6f - offset1 * 0.15f)),
                    radius = circleRadius
                ),
                radius = circleRadius,
                center = Offset(size.width * 0.7f, size.height * (0.6f - offset1 * 0.15f))
            )
        }
    }
}

@Composable
private fun GlobalUpdateBadge(message: String) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(horizontal = 20.dp, vertical = 8.dp),
        shape = RoundedCornerShape(12.dp),
        colors = CardDefaults.cardColors(
            containerColor = GlassBackground
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = 4.dp
        )
    ) {
        Row(
            modifier = Modifier.padding(12.dp),
            verticalAlignment = Alignment.CenterVertically
        ) {
            Icon(
                imageVector = Icons.Default.Refresh,
                contentDescription = "Updated",
                tint = Color.White
            )
            Spacer(modifier = Modifier.width(8.dp))
            Text(
                text = message,
                color = Color.White,
                fontSize = 14.sp
            )
        }
    }
}

/**
 * Glassmorphic snackbar.
 */
@Composable
private fun GlassmorphicSnackbar(message: String) {
    Snackbar(
        modifier = Modifier
            .padding(16.dp)
            .blur(10.dp),
        containerColor = GlassBackground,
        contentColor = Color.White,
        shape = RoundedCornerShape(16.dp)
    ) {
        Text(
            text = message,
            style = MaterialTheme.typography.bodyMedium,
            color = Color.White
        )
    }
}

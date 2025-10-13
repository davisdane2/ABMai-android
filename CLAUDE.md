# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**ABM.ai for Android** is the Android port of the native iOS application for operational intelligence in asphalt, concrete, and materials management. This repository is being prepared for migration from iOS (SwiftUI) to Android (Jetpack Compose).

**Original iOS Repository:** https://github.com/davisdane2/ABMai

**Android Repository:** https://github.com/davisdane2/ABMai-android

**Current Status:** Repository initialization phase - preparing for Android migration

## Migration Context

This repository contains the source code from **ABM.ai iOS v1.4 Beta** as reference material for the Android port. The iOS app uses SwiftUI with WKWebView-embedded HTML dashboards. The Android version will mirror this functionality using Jetpack Compose and Android WebView.

### Original iOS Architecture (Reference)

The iOS app uses a **hybrid architecture** combining native SwiftUI with WKWebView-embedded HTML dashboards:

1. **DaneApp.swift** - App entry point, launches ContentView
2. **ContentView.swift** - Main UI with glassmorphic design, category picker, and dashboard grid
3. **Dashboard.swift** - Data model defining 13 dashboards organized into 5 categories
4. **DashboardWebView.swift** - WKWebView wrapper that loads HTML dashboards from bundle resources

### Dashboard Categories (To Be Ported)

- `.inventory` - Chameleon pigments, Admixtures, Inventory submission
- `.demand` - Weekly demand analytics (Concrete, Asphalt, AC Oil, Powder, Raw Materials)
- `.operations` - Driver scheduling
- `.ai` - AI-powered tools (Concrete Quote AI, Mix Design Assist)
- `.control` - CHASCOmobile plant control interface

### HTML Dashboard Structure (Reusable for Android)

Each dashboard lives in `Dane/DashboardAssets/{DashboardName}/` as self-contained HTML files:

- HTML files will be bundled as Android assets
- Android WebView will load HTML from assets folder
- Dashboards connect to **Supabase PostgreSQL** for real-time data
- Auto-refresh intervals: 30-90 seconds per dashboard
- Mobile-optimized viewport already configured

**Good news:** HTML dashboards can be reused directly in Android with minimal modifications!

### iOS UI Design System (Reference for Android Port)

**Glassmorphic Design** (to be adapted to Material Design 3):
- Frosted glass effects (iOS: `.ultraThinMaterial`, Android: blur modifiers)
- White text on glass backgrounds for high contrast
- Gradient borders and shadows for depth
- Spring-based animations for interactions
- Background animated gradient with floating circles

Key components to port from iOS:
- `GlassmorphicCard` → Compose Card with blur effect
- `GlassmorphicDashboardCard` → Compose dashboard card
- `GlassmorphicToast` → Compose Snackbar with animations
- `ScaleButtonStyle` → Compose clickable modifier with scale animation

## Planned Android Architecture

### Technology Stack

- **Language:** Kotlin
- **UI Framework:** Jetpack Compose
- **Architecture:** MVVM with Kotlin Coroutines and Flow
- **Database Client:** Supabase Kotlin SDK
- **WebView:** AndroidView wrapping WebView for Compose
- **Network:** Ktor or Retrofit for API calls
- **Dependency Injection:** Hilt
- **Build System:** Gradle with Kotlin DSL

### Planned Project Structure

```
app/
├── src/main/
│   ├── kotlin/com/antiochbuilding/abmai/
│   │   ├── MainActivity.kt
│   │   ├── ui/
│   │   │   ├── theme/
│   │   │   ├── screens/
│   │   │   │   ├── DashboardScreen.kt
│   │   │   │   ├── CategoryScreen.kt
│   │   │   ├── components/
│   │   │   │   ├── GlassmorphicCard.kt
│   │   │   │   ├── DashboardWebView.kt
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   ├── Dashboard.kt
│   │   │   │   ├── DashboardCategory.kt
│   │   │   ├── repository/
│   │   ├── viewmodel/
│   ├── assets/
│   │   ├── dashboards/
│   │   │   ├── chameleon/
│   │   │   ├── admix/
│   │   │   └── [all HTML dashboards]
│   ├── res/
│   │   ├── drawable/
│   │   ├── values/
```

## Database & Backend

- **Backend:** Supabase PostgreSQL (same as iOS)
- **Authentication:** Will implement proper authentication (upgrading from anonymous key)
- **Security:** Full RLS (Row Level Security) for production
- **Data Access:**
  - Direct REST API queries from HTML dashboards (existing)
  - Supabase Kotlin SDK for native screens (new)

## Migration Phases

### Phase 1: Repository Setup ✅ (COMPLETED)

- [x] Create ABMai-android repository on GitHub
- [x] Copy source files from iOS version
- [x] Remove iOS-specific files (xcodeproj, build/, TestFlight docs)
- [x] Update README.md for Android context
- [x] Update CLAUDE.md with Android migration guidance

### Phase 2: Android Project Setup (NEXT)

**Steps to implement:**

1. Create new Android Studio project:
   ```bash
   # Use Android Studio: File → New → New Project
   # Select "Empty Activity" with Compose
   # Package name: com.antiochbuilding.abmai
   # Minimum SDK: API 26 (Android 8.0)
   # Build configuration: Kotlin DSL
   ```

2. Configure Gradle dependencies:
   - Jetpack Compose BOM
   - Compose Material 3
   - Compose Navigation
   - Hilt for dependency injection
   - Supabase Kotlin SDK
   - Ktor for networking
   - Coil for image loading

3. Set up project structure:
   - Create package structure
   - Copy HTML dashboards to `assets/dashboards/`
   - Create resource files (colors, strings, themes)

4. Implement Material Design 3 theme:
   - Define color scheme (adapt iOS glassmorphic palette)
   - Configure typography
   - Set up custom shapes and elevations

### Phase 3: Core Functionality Migration

**Priority order:**

1. **Data models** (Dashboard.kt, DashboardCategory.kt)
   - Port from Swift to Kotlin
   - Use sealed classes for categories
   - Data classes for dashboard definitions

2. **WebView component** (DashboardWebView composable)
   - Wrap Android WebView in AndroidView
   - Implement HTML loading from assets
   - Add navigation controls (back, forward, reload)

3. **Main screen** (DashboardScreen.kt)
   - Category selector
   - Dashboard grid with LazyVerticalGrid
   - Navigation to WebView

4. **Glassmorphic UI components**
   - GlassmorphicCard with blur effect
   - Material Design 3 card styling
   - Custom animations and transitions

### Phase 4: Feature Parity

1. Migrate all 13 dashboards
2. Implement CHASCOmobile VPN workflow
3. Add AI tools interfaces
4. Implement proper authentication

### Phase 5: Android-Specific Features

1. Widgets for quick dashboard access
2. Android Auto integration (future)
3. Tablet and foldable optimization
4. Deep linking
5. App shortcuts

## Development Commands (Once Android Project Is Created)

### Build and Run

```bash
# Build debug APK
./gradlew assembleDebug

# Install on connected device/emulator
./gradlew installDebug

# Build and run
./gradlew installDebug && adb shell am start -n com.antiochbuilding.abmai/.MainActivity

# Clean build
./gradlew clean build
```

### Testing

```bash
# Run unit tests
./gradlew test

# Run instrumented tests (requires device/emulator)
./gradlew connectedAndroidTest

# Generate test coverage report
./gradlew jacocoTestReport
```

### Release Build

```bash
# Build signed release APK
./gradlew assembleRelease

# Build Android App Bundle for Play Store
./gradlew bundleRelease
```

## Current Directory Structure

The repository currently contains iOS reference files in `Dane/`:

- **ContentView.swift** - Main UI implementation (reference for Compose screens)
- **Dashboard.swift** - Dashboard data models (port to Kotlin)
- **DashboardWebView.swift** - WebView integration (port to Compose)
- **Constants.swift** - App configuration (port to build config)
- **DashboardAssets/** - HTML dashboard files (copy to Android assets)

These Swift files will remain as reference during migration and can be removed once Android implementation is complete.

## Key Files to Create

Once Android project is initialized:

1. **app/src/main/kotlin/.../data/models/Dashboard.kt** - Port Dashboard.swift
2. **app/src/main/kotlin/.../ui/components/DashboardWebView.kt** - Port DashboardWebView.swift
3. **app/src/main/kotlin/.../ui/screens/DashboardScreen.kt** - Port ContentView.swift
4. **app/src/main/kotlin/.../MainActivity.kt** - Android app entry point
5. **app/build.gradle.kts** - Dependencies and build configuration

## Resources

### Official Documentation

- [Jetpack Compose](https://developer.android.com/jetpack/compose)
- [Material Design 3 for Compose](https://m3.material.io/)
- [Supabase Kotlin SDK](https://supabase.com/docs/reference/kotlin/introduction)
- [Android WebView](https://developer.android.com/reference/android/webkit/WebView)

### Android Studio

- Download: https://developer.android.com/studio
- Minimum version: Android Studio Hedgehog (2023.1.1) or later

## Distribution & Deployment

**Platform:** Android 8.0+ (API 26+)

**Planned Distribution Method:** Google Play Store Internal Testing → Beta → Production

**Package Name:** com.antiochbuilding.abmai

**Version Management:**
- versionCode: Integer incremented with each release
- versionName: Semantic versioning (1.0.0, 1.1.0, etc.)

## GitHub Workflow

Standard git workflow for Android development:

```bash
# Stage and commit changes
git add .
git commit -m "Description of changes

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push to remote
git push origin main

# Create pull request (if working on branch)
gh pr create --title "PR title" --body "PR description"
```

## Contact & Support

- **Developer:** dane@antiochbuilding.com
- **Issues:** https://github.com/davisdane2/ABMai-android/issues
- **Company:** Antioch Building Materials (ABM)

## Next Steps

1. Install Android Studio if not already installed
2. Create new Compose project with proper package structure
3. Set up Gradle dependencies for Compose, Material 3, Supabase
4. Copy HTML dashboards to assets folder
5. Begin porting Dashboard.swift to Kotlin data models
6. Create DashboardWebView Compose component
7. Build main dashboard screen with category navigation

---

**Remember:** The iOS Swift files in `Dane/` are for reference only. Do not modify them. All new development should be in Kotlin with Jetpack Compose.

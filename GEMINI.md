# Gemini Project Context: ABM.ai - Android

This document provides context for the ABM.ai Android project, an enterprise application for real-time operational intelligence in the construction materials industry.

## Project Overview

This project is a native Android port of an existing iOS application. The goal is to bring the full functionality of the iOS app to the Android platform, providing access to live inventory levels, demand forecasts, driver schedules, AI-powered tools, and plant control systems.

The application is being built with Kotlin and Jetpack Compose, following modern Android development best practices. It uses a "glassmorphic" design aesthetic, similar to the iOS version, but adapted to Android's Material Design 3 principles.

The backend is powered by Supabase, and the app will connect to the same Supabase PostgreSQL database as the iOS version.

## Building and Running

The project is in the early stages of development, but the basic structure is in place.

**To build and run the app:**

1.  Open the project in Android Studio.
2.  Sync the Gradle files.
3.  Run the `app` configuration on an Android emulator or a physical device.

**Key build and run commands:**

*   **Build the project:** `./gradlew build`
*   **Run the app:** Use the "Run 'app'" configuration in Android Studio.
*   **Run tests:** `./gradlew test`
*   **Run instrumented tests:** `./gradlew connectedAndroidTest`

## Development Conventions

*   **Language:** Kotlin
*   **UI:** Jetpack Compose
*   **Architecture:** MVVM with Kotlin Coroutines and Flows.
*   **Dependency Injection:** Hilt
*   **Styling:** Material Design 3 with a "glassmorphic" theme. See `app/src/main/kotlin/com/antiochbuilding/abmai/ui/theme/Theme.kt` for details.
*   **Code Formatting:** Follow standard Kotlin coding conventions.

## Key Files

*   `README.md`: The primary source of information about the project, its goals, and the migration plan from iOS.
*   `build.gradle.kts` (project-level): Defines the project-wide Gradle settings, including plugin versions.
*   `app/build.gradle.kts` (app-level): Specifies the app's dependencies, including Jetpack Compose, Hilt, Supabase, and Ktor.
*   `app/src/main/kotlin/com/antiochbuilding/abmai/MainActivity.kt`: The main entry point of the application.
*   `app/src/main/kotlin/com/antiochbuilding/abmai/ui/screens/DashboardScreen.kt`: The main UI of the app, displaying the dashboard categories and items.
*   `app/src/main/kotlin/com/antiochbuilding/abmai/data/models/Dashboard.kt`: Defines the data models for the dashboards.
*   `Dane/`: This directory contains the original Swift source code from the iOS application for reference during the migration. It is not part of the Android build.

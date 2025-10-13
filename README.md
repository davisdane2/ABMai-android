# ABM.ai - Android

> Real-time operational intelligence for asphalt, concrete, and materials management - Android Platform

**ABM.ai for Android** is the Android port of the native iOS application that brings your entire operations ecosystem to your mobile device. Access live inventory levels, demand forecasts, driver schedules, AI-powered tools, and plant control systems—all from one interface.

---

## 🚧 Project Status

**This repository is in the initial setup phase for Android migration.**

The original iOS application has been successfully deployed on TestFlight and is now being adapted for Android. This repository contains the source code foundation from the iOS version that will be transformed into a native Android application.

### Migration Plan

**Phase 1: Repository Setup** ✅
- [x] Create ABMai-android repository
- [x] Copy source files from iOS version
- [x] Remove iOS-specific files and configurations
- [x] Prepare project structure for Android development

**Phase 2: Android Project Setup** (In Progress)
- [ ] Create Android Studio project structure
- [ ] Set up Kotlin/Java project with Jetpack Compose
- [ ] Configure Gradle build system
- [ ] Establish Material Design 3 UI framework
- [ ] Port glassmorphic design concepts to Android

**Phase 3: Core Functionality Migration**
- [ ] Migrate dashboard categories and data models
- [ ] Implement WebView for HTML dashboard rendering
- [ ] Port Supabase database connectivity
- [ ] Recreate navigation and routing system
- [ ] Adapt UI components to Material Design

**Phase 4: Feature Parity**
- [ ] Migrate all 13 operational dashboards
- [ ] Implement AI-powered tools (Concrete Quote AI, Mix Design Assist)
- [ ] Port CHASCOmobile VPN integration
- [ ] Add Android-specific features (Android Auto, widgets, etc.)

**Phase 5: Testing & Distribution**
- [ ] Comprehensive testing across Android devices
- [ ] Google Play Store preparation
- [ ] Beta distribution via Play Store internal testing
- [ ] Production release

---

## 📊 Dashboard Features (To Be Implemented)

The Android version will include all features from the iOS application:

### Real-Time Dashboards

#### **Inventory Management**
- **Chameleon Inventory** - Real-time pigment tracking
- **Admix Inventory** - Admixture and dry additives monitoring
- **Inventory Submission** - Update inventory levels from anywhere

#### **Weekly Demand Analytics**
- **Concrete Demand** - Weekly concrete production forecasts
- **Asphalt Demand** - Asphalt production planning
- **AC Oil Demand** - Asphalt cement oil tracking
- **Powder Demand** - Cement, slag, and flyash monitoring
- **Raw Materials** - Combined material demand overview

#### **Operations & Scheduling**
- **Driver Schedule** - Real-time driver scheduling dashboard

#### **AI-Powered Tools**
- **Concrete Quote AI** - Instant AI-generated concrete quotes
- **Mix Design Assist** - AI-powered mix design recommendations

#### **Plant Control**
- **CHASCOmobile** - Plant control interface with VPN integration

---

## 🎨 Design Philosophy

The Android version will adapt the glassmorphic design language from iOS while embracing Material Design 3 principles:

- **Material You Theming** - Dynamic color adaptation
- **Glassmorphic Elements** - Frosted glass effects using blur and transparency
- **Modern Animations** - Smooth transitions and spring-based interactions
- **Adaptive Layouts** - Support for phones, tablets, and foldables
- **Dark Mode Support** - System-wide dark theme integration

---

## 🔧 Technology Stack (Planned)

- **Language:** Kotlin
- **UI Framework:** Jetpack Compose
- **Architecture:** MVVM with Kotlin Coroutines
- **Database Client:** Supabase Kotlin SDK
- **WebView:** Android WebView for dashboard rendering
- **Network:** Ktor or Retrofit for API calls
- **Dependency Injection:** Hilt
- **Build System:** Gradle with Kotlin DSL

---

## 📱 Platform Support

- **Minimum Android Version:** Android 8.0 (API 26)
- **Target Android Version:** Android 14 (API 34)
- **Device Support:** Phones, Tablets, Foldables
- **Android Auto Support:** Planned for future releases

---

## 🔐 Security & Database

The app will connect to the same Supabase PostgreSQL database as the iOS version:
- **Authentication:** Will implement proper authentication (upgrading from anonymous)
- **Row Level Security:** Full RLS implementation for production
- **VPN Integration:** Secure connection to plant control systems

---

## 📖 Source Material

This Android port is based on **ABM.ai for iOS v1.4 Beta**, which includes:
- 13 operational dashboards
- Glassmorphic UI design
- AI-powered tools
- CHASCOmobile VPN integration
- TestFlight beta distribution

Original iOS repository: https://github.com/davisdane2/ABMai

---

## 📝 Development Notes

The `Dane/` directory contains the Swift source files from the iOS application for reference during migration:
- `ContentView.swift` - Main UI implementation
- `Dashboard.swift` - Dashboard data models
- `DashboardWebView.swift` - WebView integration
- `Constants.swift` - App configuration
- `DashboardAssets/` - HTML dashboard files

These files serve as the blueprint for the Android implementation and will be gradually replaced with Kotlin/Compose equivalents.

---

## 🤝 Contributing

This is a private enterprise application for Antioch Building Materials employees.

For issues or questions:
- Email: dane@antiochbuilding.com
- GitHub Issues: https://github.com/davisdane2/ABMai-android/issues

---

## 📄 License

This is a private enterprise application. All rights reserved.

Dashboard logos and icons are proprietary to:
- CEMEX LLC
- Deister Machine Co.
- ASTEC (American Standard Testing & Engineering)
- CHASCO Automation

Built with:
- **Jetpack Compose** by Google (planned)
- **Supabase** for backend infrastructure
- **Claude Code** for AI-assisted development

---

**Note:** This README will be updated as the Android migration progresses. Check back for updates on implementation progress and new features.

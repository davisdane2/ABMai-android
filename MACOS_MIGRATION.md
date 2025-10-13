# macOS Migration Guide

## Status
✅ **Android project complete and pushed to GitHub**
📦 **Commit**: `7c736d5` - "Implement complete Android project structure with Jetpack Compose"
🔗 **Repository**: https://github.com/davisdane2/ABMai-android

## What's Been Completed on Linux

### ✅ Full Android Project Setup
- Complete Gradle project structure
- Jetpack Compose + Material Design 3 implementation
- All 13 HTML dashboards migrated
- Data models ported from iOS Swift to Kotlin
- Glassmorphic UI with animations
- WebView integration with lifecycle management
- 57 files added (7,427 insertions)

### ✅ Project Files Created
```
ABMai-android/
├── app/
│   ├── build.gradle.kts          (Dependencies configured)
│   ├── src/main/
│   │   ├── kotlin/               (8 Kotlin source files)
│   │   ├── assets/dashboards/    (13 HTML dashboards)
│   │   ├── res/                  (Android resources)
│   │   └── AndroidManifest.xml
├── build.gradle.kts              (Root build file)
├── settings.gradle.kts
├── gradle.properties             (Java 19 configured)
├── gradlew                       (Gradle wrapper)
└── PROJECT_SETUP.md              (Full documentation)
```

## Moving to macOS

### Step 1: Clone Repository on Mac

```bash
# Navigate to desired location
cd ~/Developer  # or your preferred location

# Clone the repository
git clone https://github.com/davisdane2/ABMai-android.git
cd ABMai-android

# Verify everything is there
ls -la
```

### Step 2: Install Required Tools on macOS

#### Install Android Studio
1. Download: https://developer.android.com/studio
2. Install Android Studio (latest stable version)
3. During setup, install:
   - Android SDK Platform 34 (Android 14)
   - Android SDK Build-Tools
   - Android Emulator
   - Android SDK Platform-Tools

#### Install Java/JDK
```bash
# Check if Java 17 or later is installed
java -version

# If not, install via Homebrew
brew install openjdk@17

# Link it
sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk \
  /Library/Java/JavaVirtualMachines/openjdk-17.jdk
```

#### Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step 3: Update gradle.properties for macOS

The current `gradle.properties` has a Linux Java path:
```properties
org.gradle.java.home=/usr/lib/jvm/jdk-19
```

**Update it to macOS Java path:**
```bash
# Find your Java home on Mac
/usr/libexec/java_home -V

# Update gradle.properties with the correct path
# Example for Homebrew OpenJDK 17:
# org.gradle.java.home=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
```

Or remove that line entirely and let Gradle use the system default.

### Step 4: Open Project in Android Studio

```bash
# Option 1: Open from command line
open -a "Android Studio" /path/to/ABMai-android

# Option 2: Open Android Studio GUI
# File → Open → Navigate to ABMai-android folder
```

#### First-Time Setup in Android Studio:
1. **Gradle Sync** will start automatically
2. If prompted, install missing SDK components
3. Accept Android licenses if prompted:
   ```bash
   # From terminal if needed
   $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses
   ```

### Step 5: Verify Build on macOS

```bash
# From project root
./gradlew clean assembleDebug

# If successful, you should see:
# BUILD SUCCESSFUL
```

### Step 6: Run on Android Device/Emulator

#### Option A: Android Emulator
1. In Android Studio: Tools → Device Manager
2. Create new device (e.g., Pixel 8 with API 34)
3. Click Run button (green play icon)

#### Option B: Physical Android Device
1. Enable Developer Options on device
2. Enable USB Debugging
3. Connect via USB
4. Click Run button

### Step 7: Test the App

Verify:
- ✅ App launches successfully
- ✅ Gradient background with animations displays
- ✅ Dashboard categories appear
- ✅ Cards are clickable
- ✅ WebView loads HTML dashboards
- ✅ HTML dashboards connect to Supabase
- ✅ Navigation works (back button, refresh)

## Why macOS?

From NOTES.md:
> **Reason:** To fully utilize the Kotlin Multiplatform plugin in Android Studio for targeting iOS, a Mac is required. The necessary tools for building and testing on iOS (like Xcode and its command-line tools) are only available on macOS.

## Next Development Steps (on macOS)

### Immediate (Android-only)
1. ✅ Verify app runs on macOS Android Studio
2. Test on physical Android device
3. Fix any platform-specific issues
4. Add app launcher icons

### Future (Kotlin Multiplatform)
1. Research Kotlin Multiplatform Mobile (KMM)
2. Share business logic between Android and iOS
3. Keep iOS SwiftUI UI layer
4. Share data models, repository, network layer

### iOS-Specific (if doing KMM)
1. Install Xcode from Mac App Store
2. Install Xcode Command Line Tools
3. Set up iOS simulator
4. Configure KMM in build.gradle.kts
5. Create shared module for cross-platform code

## Troubleshooting on macOS

### Gradle Sync Fails
```bash
# Clear Gradle cache
rm -rf ~/.gradle/caches

# In Android Studio: File → Invalidate Caches → Invalidate and Restart
```

### Java Version Issues
```bash
# Check Java version
java -version

# Should be 17 or later

# Set JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
```

### Android SDK Issues
```bash
# Set Android SDK location if not auto-detected
# Add to ~/.zshrc or ~/.bash_profile:
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

### Build Performance on M1/M2 Mac
For Apple Silicon Macs, ensure Android Studio is running natively:
- Download "Apple Silicon" version of Android Studio
- In gradle.properties, add:
  ```properties
  org.gradle.jvmargs=-Xmx4096m -XX:+UseParallelGC
  ```

## Quick Reference Commands

```bash
# Sync and build
./gradlew clean build

# Install debug APK
./gradlew installDebug

# Run tests
./gradlew test

# List devices
adb devices

# View logs
adb logcat | grep ABMai
```

## Resources

- **Project Setup**: See `PROJECT_SETUP.md`
- **Original iOS App**: https://github.com/davisdane2/ABMai
- **Android Docs**: https://developer.android.com/
- **Jetpack Compose**: https://developer.android.com/jetpack/compose
- **KMM Docs**: https://kotlinlang.org/docs/multiplatform.html

## Contact

Questions or issues during migration?
- **Developer**: dane@antiochbuilding.com
- **GitHub Issues**: https://github.com/davisdane2/ABMai-android/issues

---

**Ready to migrate!** 🚀

Pull the latest from `main` branch on your Mac and follow the steps above.

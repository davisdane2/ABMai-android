# Version Management

## Current Version: 1.4

## Versioning Policy

**Increment by 0.1 for each build until reaching 2.0**

- Start: v1.0
- Each build: +0.1 (e.g., 1.0 → 1.1 → 1.2 → 1.3 ...)
- Target: v2.0

## Version History

- **v1.4** (2025-10-12) - CHASCOmobile VPN integration with secure plant control access
  - Added VPN connection workflow with safety validation
  - Implemented warning modal for VPN requirements
  - Integrated Safari browser launch for CHASCO plant controls (10.52.10.100)
  - Added WebView navigation controls (back/forward/reload)
  - Enhanced DashboardWebView with navigation policy handling
  - Simplified CHASCOmobile HTML interface to image-based landing page
- **v1.3** (2025-10-12) - Enhanced app icons and visual assets
- **v1.2** (2025-10-12) - Fixed duplicate globals.css build error
- **v1.1** (2025-10-12) - Glassmorphic UI design and enhanced AI tools
- **v1.0** - Initial release with dashboard functionality

## How to Update Version

The app version is controlled by `MARKETING_VERSION` in the Xcode project settings.

To update for the next build:

```bash
# Replace X.Y with the next version number
sed -i '' 's/MARKETING_VERSION = X.Y;/MARKETING_VERSION = X.Z;/g' Dane.xcodeproj/project.pbxproj
```

Or manually edit `Dane.xcodeproj/project.pbxproj` and update all instances of `MARKETING_VERSION`.

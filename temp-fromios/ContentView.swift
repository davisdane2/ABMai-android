//
//  ContentView.swift
//  Dane
//
//  Created by Dane Davis on 10/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showToast = false
    @State private var toastMessage = ""
    @StateObject private var themeManager = ThemeManager()
    @State private var experimentalFeaturesEnabled = false

    // Global update badge configuration
    private let globalUpdateVersion = "1.72"  // Set to current version to show badge
    private let globalUpdateMessage = "New in v1.72 - all dashboards re-factored and some may launch externally in Safari while being integrated"
    
    // Helper to check if global update badge should show
    private var showGlobalUpdateBadge: Bool {
        guard let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return false
        }
        // Show badge if update version matches current version
        return globalUpdateVersion == currentVersion
    }

    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    navigationContent
                }
            } else {
                NavigationView {
                    navigationContent
                }
                .navigationViewStyle(.stack)
            }
        }
        .onAppear {
            // Show welcome toast
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showToastMessage("All dashboards under development and improving daily!")
            }
        }
    }

    private var navigationContent: some View {
        ZStack {
                // Background using theme colors matching globals.css
                Constants.themeBackgroundGradient(isDarkMode: themeManager.isDarkMode)
                    .ignoresSafeArea()

                // Animated background elements with theme-aware colors
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    AppColors.foreground(for: themeManager.isDarkMode).opacity(0.1),
                                    Color.clear
                                ],
                                center: .center,
                                startRadius: 0,
                                endRadius: 100
                            )
                        )
                        .frame(width: 200, height: 200)
                        .offset(
                            x: CGFloat.random(in: -200...200),
                            y: CGFloat.random(in: -200...200)
                        )
                        .animation(
                            .easeInOut(duration: Double.random(in: 3...6))
                            .repeatForever(autoreverses: true),
                            value: UUID()
                        )
                }

                // Theme toggle button in top right
                VStack {
                    HStack {
                        Spacer()
                        ThemeToggleButton(themeManager: themeManager)
                            .padding(.top, 60)
                            .padding(.trailing, 20)
                    }
                    Spacer()
                }

                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: Constants.standardPadding) {
                        // Glassmorphic Header with theme colors
                        VStack(spacing: 12) {
                            if #available(iOS 26.0, *) {
                                // iOS 26+: True liquid glass text where letters themselves are glass
                                LiquidGlassText(
                                    "ABM.ai",
                                    glass: .regular.interactive().tint(
                                        themeManager.isDarkMode
                                            ? .cyan.opacity(0.4)
                                            : .blue.opacity(0.3)
                                    ),
                                    size: 63,
                                    weight: .bold,
                                    design: .default
                                )
                                .shadow(
                                    color: AppColors
                                        .foreground(
                                            for: themeManager.isDarkMode
                                        )
                                        .opacity(0.5),
                                    radius: 20,
                                    x: 0,
                                    y: 0
                                )
                            } else if #available(iOS 18.0, *) {
                                // iOS 18-25: Glassmorphic effect on background
                                Text("ABM.ai")
                                    .font(.system(size: 63, weight: .bold, design: .default))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [
                                                AppColors.foreground(for: themeManager.isDarkMode),
                                                AppColors.foreground(for: themeManager.isDarkMode).opacity(0.9)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .shadow(
                                        color: AppColors
                                            .foreground(for: themeManager.isDarkMode)
                                            .opacity(0.3),
                                        radius: 10,
                                        x: 0,
                                        y: 0
                                    )
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .fill(.ultraThinMaterial)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 16)
                                                    .stroke(
                                                        LinearGradient(
                                                            colors: [
                                                                AppColors.foreground(for: themeManager.isDarkMode).opacity(0.2),
                                                                AppColors.foreground(for: themeManager.isDarkMode).opacity(0.1)
                                                            ],
                                                            startPoint: .topLeading,
                                                            endPoint: .bottomTrailing
                                                        ),
                                                        lineWidth: 1
                                                    )
                                            )
                                    )
                            } else {
                                // iOS 17 and earlier: Simple gradient text
                                Text("ABM.ai")
                                    .font(.system(size: 63, weight: .bold, design: .default))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [
                                                AppColors.foreground(for: themeManager.isDarkMode),
                                                AppColors.foreground(for: themeManager.isDarkMode).opacity(0.8)
                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                            }

                            HStack(spacing: 12) {
                                Link(destination: URL(string: "https://www.antiochbuilding.com/dashboard")!) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "safari")
                                            .font(.system(size: 11, weight: .medium))
                                        Text("View on web")
                                            .font(.system(size: 13, weight: .medium))
                                    }
                                    .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        Capsule()
                                            .fill(.ultraThinMaterial)
                                            .overlay(
                                                Capsule()
                                                    .stroke(
                                                        AppColors.border(for: themeManager.isDarkMode).opacity(0.3),
                                                        lineWidth: 1
                                                    )
                                            )
                                    )
                                }

                                Text("dashboards")
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode).opacity(0.9))

                                Spacer()
                            }
                            .padding(.leading, Constants.leadingContentInset)
                            
                            // Global update badge
                            if showGlobalUpdateBadge {
                                GlobalUpdateBadge(message: globalUpdateMessage, themeManager: themeManager)
                                    .padding(.horizontal, Constants.leadingContentInset)
                                    .padding(.top, 8)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 40)
                        .padding(.bottom, 20)

                        // Dashboard categories with horizontal scrolling (Apple pattern)
                        ForEach(DashboardCategory.allCases, id: \.self) { category in
                            // Skip experimental category if not enabled
                            if category != .experimental || experimentalFeaturesEnabled {
                                Group {
                                    CategoryTitleView(title: category.rawValue, themeManager: themeManager)

                                    let dashboards = Dashboard.dashboards(for: category)
                                    DashboardHorizontalListView(dashboardList: dashboards, themeManager: themeManager)
                                        .frame(height: Constants.dashboardListMinimumHeight)
                                }
                            }
                        }

                        // Experimental Features Toggle (only show if not already enabled)
                        if !experimentalFeaturesEnabled {
                            ExperimentalFeaturesToggle(
                                isEnabled: $experimentalFeaturesEnabled,
                                themeManager: themeManager
                            )
                            .padding(.horizontal, Constants.leadingContentInset)
                            .padding(.top, 20)
                        }
                    }
                    .padding(.bottom, 40)
                }
                
                // Toast Notification
                if showToast {
                    VStack {
                        GlassmorphicToast(message: toastMessage)
                            .transition(.asymmetric(
                                insertion: .move(edge: .top).combined(with: .opacity),
                                removal: .move(edge: .top).combined(with: .opacity)
                            ))
                            .padding(.top, 160)
                        Spacer()
                    }
                }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
    
    private func showToastMessage(_ message: String) {
        toastMessage = message
        withAnimation(.spring(response: Constants.springResponse, dampingFraction: Constants.springDampingFraction)) {
            showToast = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.toastDuration) {
            withAnimation(.spring(response: 0.4, dampingFraction: Constants.springDampingFraction)) {
                showToast = false
            }
        }
    }
}

// MARK: - Category and Dashboard List Views

private struct CategoryTitleView: View {
    var title: String
    var themeManager: ThemeManager

    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode))
            .padding(.top, Constants.categoryHeaderTopPadding)
            .padding(.bottom, Constants.categoryHeaderBottomPadding)
            .padding(.leading, Constants.leadingContentInset)
    }
}

struct DashboardHorizontalListView: View {
    let dashboardList: [Dashboard]
    let themeManager: ThemeManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Constants.standardPadding) {
                Spacer()
                    .frame(width: Constants.standardPadding)
                ForEach(dashboardList) { dashboard in
                    if dashboard.openInSafari {
                        // Open in Safari
                        Button(action: {
                            if let url = URL(string: dashboard.htmlPath) {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            DashboardListItemView(dashboard: dashboard, themeManager: themeManager)
                                .aspectRatio(Constants.dashboardListItemAspectRatio, contentMode: .fill)
                        }
                        .buttonStyle(.plain)
                    } else {
                        // Open in WebView
                        NavigationLink(destination: DashboardDetailView(dashboard: dashboard)) {
                            DashboardListItemView(dashboard: dashboard, themeManager: themeManager)
                                .aspectRatio(Constants.dashboardListItemAspectRatio, contentMode: .fill)
                        }
                        .buttonStyle(.plain)
                    }
                }
                Spacer()
                    .frame(width: Constants.standardPadding / 2)
            }
        }
    }
}

struct DashboardListItemView: View {
    let dashboard: Dashboard
    let themeManager: ThemeManager

    var body: some View {
        ZStack {
            // Background with icon or color using theme colors
            if dashboard.icon.hasSuffix(".png") || dashboard.icon.hasSuffix(".jpg") {
                if let uiImage = loadImageFromBundle(named: dashboard.icon) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .opacity(0.4)
                } else {
                    Rectangle()
                        .fill(Constants.primaryGradient(isDarkMode: themeManager.isDarkMode))
                }
            } else {
                // Emoji or themed gradient background
                Rectangle()
                    .fill(Constants.primaryGradient(isDarkMode: themeManager.isDarkMode))
                    .overlay {
                        Text(dashboard.icon)
                            .font(.system(size: 60))
                            .opacity(0.3)
                    }
            }
        }
        .overlay {
            ReadabilityRoundedRectangle()
        }
        .clipped()
        .cornerRadius(Constants.cornerRadius)
        .overlay(alignment: .topTrailing) {
            // "Recently Updated" badge
            if dashboard.showRecentlyUpdatedBadge {
                HStack(spacing: 4) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 10, weight: .bold))
                    Text("UPDATED")
                        .font(.system(size: 10, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Constants.primaryGradient(isDarkMode: themeManager.isDarkMode))
                )
                .padding(8)
            }
        }
        .overlay(alignment: .bottom) {
            VStack(spacing: 4) {
                Text(dashboard.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode))

                Text(dashboard.description)
                    .font(.caption)
                    .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode).opacity(0.9))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 12)
        }
        .shadow(color: .black.opacity(Constants.glassShadowOpacity), radius: Constants.glassShadowRadius)
    }

    // Helper function to load image from bundle
    private func loadImageFromBundle(named name: String) -> UIImage? {
        let baseName = name.replacingOccurrences(of: ".png", with: "")
            .replacingOccurrences(of: ".jpg", with: "")

        if let path = Bundle.main.path(forResource: baseName, ofType: "png") {
            return UIImage(contentsOfFile: path)
        } else if let path = Bundle.main.path(forResource: baseName, ofType: "jpg") {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
}

// MARK: - Glassmorphic Components

struct GlassmorphicCard<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Constants.glassBackgroundStyle)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(Constants.glassOpacity),
                                        Color.white.opacity(0.1)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
            )
            .shadow(color: .black.opacity(Constants.glassShadowOpacity), radius: Constants.glassShadowRadius, x: 0, y: 5)
    }
}

struct GlassmorphicDashboardCard: View {
    let dashboard: Dashboard

    var body: some View {
        VStack(spacing: Constants.standardPadding) {
            // Icon with glassmorphic background
            ZStack {
                Circle()
                    .fill(Constants.glassBackgroundStyle)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(Constants.glassStrokeOpacity), lineWidth: 1)
                    )

                // "Recently Updated" small badge on icon
                if dashboard.showRecentlyUpdatedBadge {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [Color.green, Color.blue],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 20, height: 20)
                        .overlay(
                            Image(systemName: "sparkles")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundColor(.white)
                        )
                        .offset(x: 25, y: -25)
                }

                if dashboard.icon.hasSuffix(".png") || dashboard.icon.hasSuffix(".jpg") {
                    if let uiImage = loadImageFromBundle(named: dashboard.icon) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .opacity(0.4)
                    } else {
                        Image(systemName: "app.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                } else {
                    Text(dashboard.icon)
                        .font(.system(size: 30))
                }
            }

            // Name
            Text(dashboard.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            // Description
            Text(dashboard.description)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding(Constants.leadingContentInset)
        .background(
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .fill(Constants.glassBackgroundStyle)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(Constants.glassOpacity),
                                    Color.white.opacity(0.1)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
        )
        .shadow(color: .black.opacity(Constants.glassShadowOpacity), radius: Constants.glassShadowRadius, x: 0, y: 5)
    }

    // Helper function to load image from bundle
    private func loadImageFromBundle(named name: String) -> UIImage? {
        let baseName = name.replacingOccurrences(of: ".png", with: "")
            .replacingOccurrences(of: ".jpg", with: "")

        if let path = Bundle.main.path(forResource: baseName, ofType: "png") {
            return UIImage(contentsOfFile: path)
        } else if let path = Bundle.main.path(forResource: baseName, ofType: "jpg") {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
}

struct GlassmorphicToast: View {
    let message: String
    @State private var showIcon = false
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: 32, height: 32)
                    .overlay(
                        Circle()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
                
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .scaleEffect(showIcon ? 1.0 : 0.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showIcon)
            }
            
            Text(message)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                )
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                showIcon = true
            }
        }
    }
}

// MARK: - Legacy DashboardCard (kept for compatibility)

struct DashboardCard: View {
    let dashboard: Dashboard

    var body: some View {
        VStack(spacing: 12) {
            // Icon - display image if it's a file, otherwise show as emoji
            if dashboard.icon.hasSuffix(".png") || dashboard.icon.hasSuffix(".jpg") {
                if let uiImage = loadImageFromBundle(named: dashboard.icon) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .opacity(0.4)
                } else {
                    // Fallback if image not found
                    Image(systemName: "app.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                }
            } else {
                // Display emoji
                Text(dashboard.icon)
                    .font(.system(size: 50))
            }

            // Name
            Text(dashboard.name)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            // Description
            Text(dashboard.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }

    // Helper function to load image from bundle
    private func loadImageFromBundle(named name: String) -> UIImage? {
        // Remove extension to get the base name
        let baseName = name.replacingOccurrences(of: ".png", with: "")
            .replacingOccurrences(of: ".jpg", with: "")

        // Try to load from bundle
        if let path = Bundle.main.path(forResource: baseName, ofType: "png") {
            return UIImage(contentsOfFile: path)
        } else if let path = Bundle.main.path(forResource: baseName, ofType: "jpg") {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
}

// MARK: - Global Update Badge

struct GlobalUpdateBadge: View {
    let message: String
    let themeManager: ThemeManager
    @State private var isAnimated = false
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: "sparkles")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .scaleEffect(isAnimated ? 1.2 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: isAnimated
                    )
                
                Text("UPDATED")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Constants.primaryGradient(isDarkMode: themeManager.isDarkMode))
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                    )
            )
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode).opacity(0.8))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            AppColors.border(for: themeManager.isDarkMode).opacity(0.2),
                            lineWidth: 1
                        )
                )
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 5,
            x: 0,
            y: 2
        )
        .onAppear {
            isAnimated = true
        }
    }
}

// MARK: - Custom Button Style

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Experimental Features Toggle

struct ExperimentalFeaturesToggle: View {
    @Binding var isEnabled: Bool
    let themeManager: ThemeManager
    @State private var pulseAnimation = false

    var body: some View {
        VStack(spacing: 16) {
            // Teaser image
            if let uiImage = loadImageFromBundle(named: "watchiconfinal.png") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 80)
                    .opacity(0.8)
                    .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                        value: pulseAnimation
                    )
            }

            Text("Experimental Features")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode))

            Text("Enable access to experimental dashboards and beta features")
                .font(.subheadline)
                .foregroundColor(AppColors.foreground(for: themeManager.isDarkMode).opacity(0.7))
                .multilineTextAlignment(.center)

            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                    isEnabled = true
                }
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "flask")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Activate Experimental Features")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 14)
                .background(
                    Capsule()
                        .fill(Constants.primaryGradient(isDarkMode: themeManager.isDarkMode))
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                )
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(
                            AppColors.border(for: themeManager.isDarkMode).opacity(0.3),
                            lineWidth: 1
                        )
                )
        )
        .shadow(
            color: .black.opacity(0.1),
            radius: 10,
            x: 0,
            y: 5
        )
        .onAppear {
            pulseAnimation = true
        }
    }

    private func loadImageFromBundle(named name: String) -> UIImage? {
        let baseName = name.replacingOccurrences(of: ".png", with: "")
            .replacingOccurrences(of: ".jpg", with: "")

        if let path = Bundle.main.path(forResource: baseName, ofType: "png") {
            return UIImage(contentsOfFile: path)
        } else if let path = Bundle.main.path(forResource: baseName, ofType: "jpg") {
            return UIImage(contentsOfFile: path)
        }
        return nil
    }
}

#Preview {
    ContentView()
}

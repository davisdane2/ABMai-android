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

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    colors: [
                        Color(red: 0.1, green: 0.1, blue: 0.3),
                        Color(red: 0.2, green: 0.1, blue: 0.4),
                        Color(red: 0.1, green: 0.2, blue: 0.5)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // Animated background elements
                ForEach(0..<3, id: \.self) { index in
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [
                                    Color.white.opacity(0.1),
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

                ScrollView(showsIndicators: false) {
                    LazyVStack(alignment: .leading, spacing: Constants.standardPadding) {
                        // Glassmorphic Header
                        VStack(spacing: 12) {
                            Text("ABM.ai")
                                .font(.system(size: 52, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.white, .white.opacity(0.8)],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .shadow(color: .white.opacity(0.3), radius: 10, x: 0, y: 0)

                            Text("dashboards")
                                .font(.title2)
                                .fontWeight(.medium)
                                .foregroundColor(.white.opacity(0.9))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 40)
                        .padding(.bottom, 20)

                        // Dashboard categories with horizontal scrolling (Apple pattern)
                        ForEach(DashboardCategory.allCases, id: \.self) { category in
                            Group {
                                CategoryTitleView(title: category.rawValue)

                                let dashboards = Dashboard.dashboards(for: category)
                                DashboardHorizontalListView(dashboardList: dashboards)
                                    .frame(height: Constants.dashboardListMinimumHeight)
                            }
                        }
                    }
                    .padding(.bottom, 40)
                }
                
                // Toast Notification
                if showToast {
                    VStack {
                        Spacer()
                        GlassmorphicToast(message: toastMessage)
                            .transition(.asymmetric(
                                insertion: .move(edge: .bottom).combined(with: .opacity),
                                removal: .move(edge: .bottom).combined(with: .opacity)
                            ))
                            .padding(.bottom, 100)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .onAppear {
            // Show welcome toast
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showToastMessage("Welcome to ABM.ai Dashboards!")
            }
        }
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

    var body: some View {
        Text(title)
            .font(.title2)
            .bold()
            .foregroundColor(.white)
            .padding(.top, Constants.categoryHeaderTopPadding)
            .padding(.bottom, Constants.categoryHeaderBottomPadding)
            .padding(.leading, Constants.leadingContentInset)
    }
}

struct DashboardHorizontalListView: View {
    let dashboardList: [Dashboard]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Constants.standardPadding) {
                Spacer()
                    .frame(width: Constants.standardPadding)
                ForEach(dashboardList) { dashboard in
                    NavigationLink(destination: DashboardDetailView(dashboard: dashboard)) {
                        DashboardListItemView(dashboard: dashboard)
                            .aspectRatio(Constants.dashboardListItemAspectRatio, contentMode: .fill)
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
                    .frame(width: Constants.standardPadding / 2)
            }
        }
    }
}

struct DashboardListItemView: View {
    let dashboard: Dashboard

    var body: some View {
        ZStack {
            // Background with icon or color
            if dashboard.icon.hasSuffix(".png") || dashboard.icon.hasSuffix(".jpg") {
                if let uiImage = loadImageFromBundle(named: dashboard.icon) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                } else {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            } else {
                // Emoji or solid color background
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
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
        .overlay(alignment: .bottom) {
            VStack(spacing: 4) {
                Text(dashboard.name)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Text(dashboard.description)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
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

                if dashboard.icon.hasSuffix(".png") || dashboard.icon.hasSuffix(".jpg") {
                    if let uiImage = loadImageFromBundle(named: dashboard.icon) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
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

// MARK: - Custom Button Style

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    ContentView()
}

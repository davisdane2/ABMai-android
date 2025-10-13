//
//  Constants.swift
//  Dane
//
//  Created by Dane Davis on 10/12/25.
//  Design constants following Apple's Landmarks pattern

import SwiftUI

/// Constant values that the app defines for consistent design system.
struct Constants {
    // MARK: App-wide constants

    static let cornerRadius: CGFloat = 20.0
    static let leadingContentInset: CGFloat = 20.0
    static let standardPadding: CGFloat = 16.0
    static let dashboardImagePadding: CGFloat = 14.0
    static let safeAreaPadding: CGFloat = 30.0
    static let titleTopPadding: CGFloat = 8.0
    static let titleBottomPadding: CGFloat = -4.0

    // MARK: Dashboard grid constants

    static let dashboardGridSpacing: CGFloat = 16.0

    @MainActor static var dashboardGridItemMinSize: CGFloat {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 180.0
        } else {
            return 160.0
        }
        #else
        return 180.0
        #endif
    }

    static let dashboardGridItemMaxSize: CGFloat = 200.0

    // MARK: Dashboard list constants

    static let dashboardListItemAspectRatio: CGFloat = 1.4
    static let dashboardListPercentOfHeight: CGFloat = 0.22
    static let dashboardListMinimumHeight: CGFloat = 160.0

    // MARK: Category header constants

    static let categoryHeaderTopPadding: CGFloat = 20.0
    static let categoryHeaderBottomPadding: CGFloat = 12.0

    // MARK: Glass effect constants

    static let glassOpacity: CGFloat = 0.3
    static let glassStrokeOpacity: CGFloat = 0.2
    static let glassBlurRadius: CGFloat = 10.0
    static let glassShadowOpacity: CGFloat = 0.1
    static let glassShadowRadius: CGFloat = 10.0

    // MARK: Animation constants

    static let standardAnimationDuration: CGFloat = 0.3
    static let springResponse: CGFloat = 0.6
    static let springDampingFraction: CGFloat = 0.8

    // MARK: Toast constants

    static let toastDuration: CGFloat = 3.0
    static let toastBottomPadding: CGFloat = 100.0

    // MARK: Style

    #if os(macOS)
    static let editingBackgroundStyle = WindowBackgroundShapeStyle.windowBackground
    #else
    static let editingBackgroundStyle = Material.ultraThickMaterial
    #endif

    static let glassBackgroundStyle = Material.ultraThinMaterial
}

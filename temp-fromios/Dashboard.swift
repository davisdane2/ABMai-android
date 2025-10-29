//
//  Dashboard.swift
//  Dane
//
//  Created by Dane Davis on 10/10/25.
//

import Foundation

struct Dashboard: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    let htmlPath: String
    let category: DashboardCategory
    let recentlyUpdatedInVersion: String? // Version when dashboard was updated (e.g., "1.42")
    let openInSafari: Bool // Whether to open in Safari instead of in-app

    // Helper to check if "Recently Updated" badge should show
    var showRecentlyUpdatedBadge: Bool {
        guard let updateVersion = recentlyUpdatedInVersion,
              let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return false
        }
        // Show badge if update version matches current version
        return updateVersion == currentVersion
    }
}

enum DashboardCategory: String, CaseIterable {
    case inventory = "Inventory"
    case demand = "Product Demand Dashboards"
    case operations = "Schedule & DF"
    case ai = "AI Tools + ChatBot Links"
    case control = "CHASCOmobile"
    case experimental = "ABMcoin"
}

extension Dashboard {
    static let allDashboards = [
        // Inventory Dashboards
        Dashboard(
            name: "Chameleon Inventory",
            description: "Chameleon Inventory for BW & Pit",
            icon: "chameleon.png",
            htmlPath: "https://v0-next-js-dashboard-page-murex.vercel.app/",
            category: .inventory,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Admix Inventory",
            description: "Admixture (Dry Goods) Inventory for Bw & Pit",
            icon: "cemexlogo.png",
            htmlPath: "https://v0-admixture-inventory-tracker.vercel.app/admixture",
            category: .inventory,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Inventory Submission",
            description: "Update Inventories For BW & Pit + RAP area",
            icon: "deister.png",
            htmlPath: "InventorySubmission.html",
            category: .inventory,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: false
        ),

        // Weekly Demand Dashboards
        Dashboard(
            name: "All Raw Material Demands",
            description: "Combined Raw Material Demands",
            icon: "rawmatlogo.png",
            htmlPath: "https://www.antiochbuilding.com/abminfo/abminfo/conc.html",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Concrete Demand",
            description: "Weekly Concrete Demand",
            icon: "coneco.png",
            htmlPath: "https://jonel-demand-dash.lovable.app/",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Concrete Demand (altView)",
            description: "More info in a single page",
            icon: "jonel.png",
            htmlPath: "ConcDemandWeekalt.html",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: false
        ),
        Dashboard(
            name: "Asphalt Demand",
            description: "Weekly Asphalt Demand",
            icon: "astelogo.png",
            htmlPath: "https://jonel-demand-dash.lovable.app/",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "AC Oil Demand",
            description: "Weekly AC OIL Demand",
            icon: "acoillogo.png",
            htmlPath: "https://v0-next-js-dashboard-with-supabase.vercel.app/asphalt-oil",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Powder Demand",
            description: "Weekly Cement/Slag/Flyash Demand",
            icon: "cementlogo.png",
            htmlPath: "PowderWeekly.html",
            category: .demand,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: false
        ),
       

        // Operations
        Dashboard(
            name: "Driver Schedule",
            description: "Driver Start Times & Schedule",
            icon: "dflogo.png",
            htmlPath: "ScheduleDash.html",
            category: .operations,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: false
        ),
        Dashboard(
            name: "Samsara Live Truck Link",
            description: "Create or view a truck navigation link",
            icon: "samsarabutton.png",
            htmlPath: "https://v0-samsara-api-gui.vercel.app/",
            category: .operations,
            recentlyUpdatedInVersion: "1.72",
            openInSafari: true
        ),

        // AI Tools
        Dashboard(
            name: "Concrete Quote AI",
            description: "AI-powered Concrete Quick-Quote",
            icon: "zapierchat.png",
            htmlPath: "https://concrete-price.zapier.app/",
            category: .ai,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),
        Dashboard(
            name: "Mix Design Assist",
            description: "AI Mix Design Selector",
            icon: "mixgpt3.png",
            htmlPath: "https://mix-design-assist.zapier.app/",
            category: .ai,
            recentlyUpdatedInVersion: "1.70",
            openInSafari: true
        ),

        // Plant Control
        Dashboard(
            name: "CHASCOmobile",
            description: "Plant Control Interface for CHASCO",
            icon: "chascologo.png",
            htmlPath: "index.html",
            category: .control,
            recentlyUpdatedInVersion: nil,
            openInSafari: false
        ),
        // Management
        Dashboard(
            name: "Margin Report",
            description: "Management Margin Report",
            icon: "margin.png",
            htmlPath: "https://www.antiochbuilding.com/dashboard/marginpath.html",
            category: .control,
            recentlyUpdatedInVersion: nil,
            openInSafari: true
        ),
        Dashboard(
            name: "ABM coin",
            description: "Experimental Devnet Information",
            icon: "watchiconfinal.png",
            htmlPath: "wallet-guide-ios.html",
            category: .experimental,
            recentlyUpdatedInVersion: "1.73",
            openInSafari: false
        )   ]

    static func dashboards(for category: DashboardCategory) -> [Dashboard] {
        allDashboards.filter { $0.category == category }
    }
}

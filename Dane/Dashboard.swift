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
}

enum DashboardCategory: String, CaseIterable {
    case inventory = "Inventory"
    case demand = "ProductDemands"
    case operations = "Schedule & DF"
    case ai = "AI ChatBot Tools"
    case control = "CHASCOmobile"
}

extension Dashboard {
    static let allDashboards = [
        // Inventory Dashboards
        Dashboard(
            name: "Chameleon Inventory",
            description: "Pittsburg & Brentwood chameleon inventory",
            icon: "🦎",
            htmlPath: "chameleon.html",
            category: .inventory
        ),
        Dashboard(
            name: "Admix Inventory",
            description: "Admixture & Dry Additives inventory Pit&BW",
            icon: "cemexlogo.png",
            htmlPath: "Admix.html",
            category: .inventory
        ),
        Dashboard(
            name: "Inventory Submission",
            description: "Update Inventories for your department",
            icon: "deister.png",
            htmlPath: "InventorySubmission.html",
            category: .inventory
        ),

        // Weekly Demand Dashboards
        Dashboard(
            name: "Concrete Demand",
            description: "Weekly concrete demand dashboard",
            icon: "coneco.png",
            htmlPath: "ConcWeekly.html",
            category: .demand
        ),
        Dashboard(
            name: "Asphalt Demand",
            description: "Weekly asphalt demand dashboard",
            icon: "astelogo.png",
            htmlPath: "AsphaltWeekly.html",
            category: .demand
        ),
        Dashboard(
            name: "AC Oil Demand",
            description: "Weekly AC oil tracking",
            icon: "acoillogo.png",
            htmlPath: "ACoilWeekly.html",
            category: .demand
        ),
        Dashboard(
            name: "Powder Demand",
            description: "Weekly Cement/Slag/Flyash powder demand",
            icon: "cementlogo.png",
            htmlPath: "PowderWeekly.html",
            category: .demand
        ),
        Dashboard(
            name: "All Raw Material Demands",
            description: "Combined raw material demand",
            icon: "rawmatlogo.png",
            htmlPath: "RawWeeklyComb.html",
            category: .demand
        ),

        // Operations
        Dashboard(
            name: "Driver Schedule",
            description: "Driver scheduling dashboard",
            icon: "dflogo.png",
            htmlPath: "ScheduleDash.html",
            category: .operations
        ),

        // AI Tools
        Dashboard(
            name: "Concrete Quote AI",
            description: "AI-powered concrete quotes",
            icon: "zapierchat.png",
            htmlPath: "ConcQuoteBot.html",
            category: .ai
        ),
        Dashboard(
            name: "Mix Design Assist",
            description: "AI mix design assistance",
            icon: "mixlogodesign.png",
            htmlPath: "MixDesignAI.html",
            category: .ai
        ),

        // Plant Control
        Dashboard(
            name: "CHASCOmobile",
            description: "plant control interface for CHASCO asphalt plant controls",
            icon: "chascologo.png",
            htmlPath: "index.html",
            category: .control
        )
    ]

    static func dashboards(for category: DashboardCategory) -> [Dashboard] {
        allDashboards.filter { $0.category == category }
    }
}

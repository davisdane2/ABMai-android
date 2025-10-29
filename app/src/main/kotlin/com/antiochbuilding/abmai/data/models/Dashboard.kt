package com.antiochbuilding.abmai.data.models

import android.content.Context
import java.util.UUID

/**
 * Data model representing a dashboard in the ABM.ai application.
 * Each dashboard has a unique identifier, display information, and references
 * to its HTML content stored in assets.
 */
data class Dashboard(
    val id: String = UUID.randomUUID().toString(),
    val name: String,
    val description: String,
    val icon: String,
    val htmlPath: String,
    val category: DashboardCategory,
    val recentlyUpdatedInVersion: String?,
    val openInSafari: Boolean
) {
    fun showRecentlyUpdatedBadge(context: Context): Boolean {
        val (versionName, _) = getAppVersion(context)
        return recentlyUpdatedInVersion == versionName
    }
}

/**
 * Categories of dashboards available in the application.
 * Each category groups related dashboards together.
 */
enum class DashboardCategory(val displayName: String) {
    INVENTORY("Inventory"),
    DEMAND("Product Demand Dashboards"),
    OPERATIONS("Schedule & DF"),
    AI("AI Tools + ChatBot Links"),
    CONTROL("CHASCOmobile"),
    EXPERIMENTAL("ABMcoin");

    companion object {
        fun fromDisplayName(name: String): DashboardCategory? {
            return entries.find { it.displayName == name }
        }
    }
}

/**
 * Repository of all available dashboards in the application.
 * Provides static access to the complete dashboard catalog.
 */
object DashboardRepository {

    val allDashboards = listOf(
        // Inventory Dashboards
        Dashboard(
            name = "Chameleon Inventory",
            description = "Chameleon Inventory for BW & Pit",
            icon = "chameleon.png",
            htmlPath = "https://v0-next-js-dashboard-page-murex.vercel.app/",
            category = DashboardCategory.INVENTORY,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Admix Inventory",
            description = "Admixture (Dry Goods) Inventory for Bw & Pit",
            icon = "cemexlogo.png",
            htmlPath = "https://v0-admixture-inventory-tracker.vercel.app/admixture",
            category = DashboardCategory.INVENTORY,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Inventory Submission",
            description = "Update Inventories For BW & Pit + RAP area",
            icon = "deister.png",
            htmlPath = "InventorySubmission.html",
            category = DashboardCategory.INVENTORY,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = false
        ),

        // Weekly Demand Dashboards
        Dashboard(
            name = "All Raw Material Demands",
            description = "Combined Raw Material Demands",
            icon = "rawmatlogo.png",
            htmlPath = "https://www.antiochbuilding.com/abminfo/abminfo/conc.html",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Concrete Demand",
            description = "Weekly Concrete Demand",
            icon = "coneco.png",
            htmlPath = "https://jonel-demand-dash.lovable.app/",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Concrete Demand (altView)",
            description = "More info in a single page",
            icon = "jonel.png",
            htmlPath = "ConcDemandWeekalt.html",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = false
        ),
        Dashboard(
            name = "Asphalt Demand",
            description = "Weekly Asphalt Demand",
            icon = "astelogo.png",
            htmlPath = "https://jonel-demand-dash.lovable.app/",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "AC Oil Demand",
            description = "Weekly AC OIL Demand",
            icon = "acoillogo.png",
            htmlPath = "https://v0-next-js-dashboard-with-supabase.vercel.app/asphalt-oil",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Powder Demand",
            description = "Weekly Cement/Slag/Flyash Demand",
            icon = "cementlogo.png",
            htmlPath = "PowderWeekly.html",
            category = DashboardCategory.DEMAND,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = false
        ),


        // Operations
        Dashboard(
            name = "Driver Schedule",
            description = "Driver Start Times & Schedule",
            icon = "dflogo.png",
            htmlPath = "ScheduleDash.html",
            category = DashboardCategory.OPERATIONS,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = false
        ),
        Dashboard(
            name = "Samsara Live Truck Link",
            description = "Create or view a truck navigation link",
            icon = "samsarabutton.png",
            htmlPath = "https://v0-samsara-api-gui.vercel.app/",
            category = DashboardCategory.OPERATIONS,
            recentlyUpdatedInVersion = "1.72",
            openInSafari = true
        ),

        // AI Tools
        Dashboard(
            name = "Concrete Quote AI",
            description = "AI-powered Concrete Quick-Quote",
            icon = "zapierchat.png",
            htmlPath = "https://concrete-price.zapier.app/",
            category = DashboardCategory.AI,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),
        Dashboard(
            name = "Mix Design Assist",
            description = "AI Mix Design Selector",
            icon = "mixgpt3.png",
            htmlPath = "https://mix-design-assist.zapier.app/",
            category = DashboardCategory.AI,
            recentlyUpdatedInVersion = "1.70",
            openInSafari = true
        ),

        // Plant Control
        Dashboard(
            name = "CHASCOmobile",
            description = "Plant Control Interface for CHASCO",
            icon = "chascologo.png",
            htmlPath = "index.html",
            category = DashboardCategory.CONTROL,
            recentlyUpdatedInVersion = null,
            openInSafari = false
        ),
        // Management
        Dashboard(
            name = "Margin Report",
            description = "Management Margin Report",
            icon = "margin.png",
            htmlPath = "https://www.antiochbuilding.com/dashboard/marginpath.html",
            category = DashboardCategory.CONTROL,
            recentlyUpdatedInVersion = null,
            openInSafari = true
        ),
        Dashboard(
            name = "ABM coin",
            description = "Experimental Devnet Information",
            icon = "watchiconfinal.png",
            htmlPath = "wallet-guide-ios.html",
            category = DashboardCategory.EXPERIMENTAL,
            recentlyUpdatedInVersion = "1.73",
            openInSafari = false
        )
    )

    /**
     * Filter dashboards by category.
     */
    fun getDashboardsByCategory(category: DashboardCategory): List<Dashboard> {
        return allDashboards.filter { it.category == category }
    }

    /**
     * Get a dashboard by its ID.
     */
    fun getDashboardById(id: String): Dashboard? {
        return allDashboards.find { it.id == id }
    }

    /**
     * Get all unique categories that have dashboards.
     */
    fun getAllCategories(): List<DashboardCategory> {
        return allDashboards.map { it.category }.distinct()
    }
}
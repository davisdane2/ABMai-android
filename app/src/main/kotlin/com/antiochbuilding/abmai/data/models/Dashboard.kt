package com.antiochbuilding.abmai.data.models

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
    val category: DashboardCategory
)

/**
 * Categories of dashboards available in the application.
 * Each category groups related dashboards together.
 */
enum class DashboardCategory(val displayName: String) {
    INVENTORY("Inventory"),
    DEMAND("Product Demands"),
    OPERATIONS("Schedule & DF"),
    AI("AI ChatBot Tools"),
    CONTROL("CHASCOmobile");

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
            description = "Pittsburg & Brentwood chameleon inventory",
            icon = "🦎",
            htmlPath = "dashboards/ChameleonInventory/chameleon.html",
            category = DashboardCategory.INVENTORY
        ),
        Dashboard(
            name = "Admix Inventory",
            description = "Admixture & Dry Additives inventory Pit&BW",
            icon = "cemexlogo.png",
            htmlPath = "dashboards/AdmixInventory/Admix.html",
            category = DashboardCategory.INVENTORY
        ),
        Dashboard(
            name = "Inventory Submission",
            description = "Update Inventories for your department",
            icon = "deister.png",
            htmlPath = "dashboards/InventorySubmission/InventorySubmission.html",
            category = DashboardCategory.INVENTORY
        ),

        // Weekly Demand Dashboards
        Dashboard(
            name = "Concrete Demand",
            description = "Weekly concrete demand dashboard",
            icon = "coneco.png",
            htmlPath = "dashboards/ConcreteDemandWeekly/ConcWeekly.html",
            category = DashboardCategory.DEMAND
        ),
        Dashboard(
            name = "Asphalt Demand",
            description = "Weekly asphalt demand dashboard",
            icon = "astelogo.png",
            htmlPath = "dashboards/AsphaltDemandWeekly/AsphaltWeekly.html",
            category = DashboardCategory.DEMAND
        ),
        Dashboard(
            name = "AC Oil Demand",
            description = "Weekly AC oil tracking",
            icon = "acoillogo.png",
            htmlPath = "dashboards/ACoilWeekly/ACoilWeekly.html",
            category = DashboardCategory.DEMAND
        ),
        Dashboard(
            name = "Powder Demand",
            description = "Weekly Cement/Slag/Flyash powder demand",
            icon = "cementlogo.png",
            htmlPath = "dashboards/PowderWeekly/PowderWeekly.html",
            category = DashboardCategory.DEMAND
        ),
        Dashboard(
            name = "All Raw Material Demands",
            description = "Combined raw material demand",
            icon = "rawmatlogo.png",
            htmlPath = "dashboards/RawMaterialDemandCombWeekly/RawWeeklyComb.html",
            category = DashboardCategory.DEMAND
        ),

        // Operations
        Dashboard(
            name = "Driver Schedule",
            description = "Driver scheduling dashboard",
            icon = "dflogo.png",
            htmlPath = "dashboards/ScheduleDashboard/ScheduleDash.html",
            category = DashboardCategory.OPERATIONS
        ),

        // AI Tools
        Dashboard(
            name = "Concrete Quote AI",
            description = "AI-powered concrete quotes",
            icon = "zapierchat.png",
            htmlPath = "dashboards/ConcreteQuoteAI/ConcQuoteBot.html",
            category = DashboardCategory.AI
        ),
        Dashboard(
            name = "Mix Design Assist",
            description = "AI mix design assistance",
            icon = "mixlogodesign.png",
            htmlPath = "dashboards/MixDesignAssistAI/MixDesignAI.html",
            category = DashboardCategory.AI
        ),

        // Plant Control
        Dashboard(
            name = "CHASCOmobile",
            description = "Plant control interface for CHASCO asphalt plant controls",
            icon = "chascologo.png",
            htmlPath = "dashboards/CHASCOmobile/index.html",
            category = DashboardCategory.CONTROL
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

package com.antiochbuilding.abmai.data.models

import android.content.Context
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.os.Build

fun getAppVersion(context: Context): Pair<String, Long> {
    try {
        val packageName = context.packageName
        val packageInfo: PackageInfo = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            context.packageManager.getPackageInfo(packageName, PackageManager.PackageInfoFlags.of(0L))
        } else {
            @Suppress("DEPRECATION")
            context.packageManager.getPackageInfo(packageName, 0)
        }
        return Pair(packageInfo.versionName, getVersionCode(packageInfo))
    } catch (e: PackageManager.NameNotFoundException) {
        e.printStackTrace()
    }
    return Pair("Unknown", 0L)
}

@Suppress("DEPRECATION")
private fun getVersionCode(packageInfo: PackageInfo): Long {
    return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
        packageInfo.longVersionCode
    } else {
        packageInfo.versionCode.toLong()
    }
}
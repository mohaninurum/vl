//pluginManagement {
//    val flutterSdkPath = run {
//        val properties = java.util.Properties()
//        file("local.properties").inputStream().use { properties.load(it) }
//        val flutterSdkPath = properties.getProperty("flutter.sdk")
//        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//        flutterSdkPath
//    }
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//    }
//}
//dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//plugins {
//
////    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//    id("com.android.application") version "8.2.2" apply false
//    // START: FlutterFire Configuration
//    id("com.google.gms.google-services") version("4.3.15") apply false
//    // END: FlutterFire Configuration
//    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
//}
//1.8.22
//include(":app")
//pluginManagement {
//    val flutterSdkPath = run {
//        val properties = java.util.Properties()
//        file("local.properties").inputStream().use { properties.load(it) }
//        val flutterSdkPath = properties.getProperty("flutter.sdk")
//        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//        flutterSdkPath
//    }
//
//    // ✅ Include Flutter Gradle plugin
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//    }
//}
//

//
//
//// ✅ Set project name (optional but recommended)
//rootProject.name = "visual_learning"
//
//include(":app")
//pluginManagement {
//    val flutterSdkPath = run {
//        val properties = java.util.Properties()
//        file("local.properties").inputStream().use { properties.load(it) }
//        val flutterSdkPath = properties.getProperty("flutter.sdk")
//        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//        flutterSdkPath
//    }
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//        maven {
//            url = uri("https://storage.googleapis.com/download.flutter.io") // ✅ Add this
//        }
//    }
//}
//
//dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
//    repositories {
//        google()
//        mavenCentral()
//        maven {
//            url = uri("https://storage.googleapis.com/download.flutter.io") // ✅ Add this
//        }
//
//
//    }
//}
//
//include(":app")
//
//pluginManagement {
//    val flutterSdkPath = run {
//        val properties = java.util.Properties()
//        file("local.properties").inputStream().use { properties.load(it) }
//        val flutterSdkPath = properties.getProperty("flutter.sdk")
//        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//        flutterSdkPath
//    }
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//        maven {
//            url = uri("https://storage.googleapis.com/download.flutter.io")
//        }
//    }
//}
//
//dependencyResolutionManagement {
//    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
//    repositories {
//        google()
//        mavenCentral()
//        maven {
//            url = uri("https://storage.googleapis.com/download.flutter.io")
//        }
//    }
//}
//plugins {
//
////    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//    id("com.android.application") version "8.2.2" apply false
//    // START: FlutterFire Configuration
//    id("com.google.gms.google-services") version("4.3.15") apply false
//    // END: FlutterFire Configuration
//    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
//}
//include(":app")


//
pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
        maven {
            url = uri("https://storage.googleapis.com/download.flutter.io")
        }
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.PREFER_SETTINGS)
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://storage.googleapis.com/download.flutter.io")
        }
    }
}
plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.7.0" apply false
    id("com.google.gms.google-services") version "4.4.1" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
}
rootProject.name = "visual_learning"
include(":app")



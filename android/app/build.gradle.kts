//
//
//plugins {
////    id("com.android.application")
////    // START: FlutterFire Configuration
////    id("com.google.gms.google-services")
////    // END: FlutterFire Configuration
////    id("kotlin-android")
////    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
////    id("dev.flutter.flutter-gradle-plugin")
////    id("org.jetbrains.kotlin.android")
//    id("com.android.application")
//    id("org.jetbrains.kotlin.android")
//    id("com.google.gms.google-services")
//
//
//}
//
//android {
//    namespace = "com.example.visual_learning"
//    compileSdk = 35
//    ndkVersion = "27.0.12077973"
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.example.visual_learning"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdk = 23
//        targetSdk = 35
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//flutter {
//    source = "../.."
//}
////dependencies {
////    implementation(platform("com.google.firebase:firebase-bom:32.7.3")) // ✅ Firebase BOM
////    implementation("com.google.firebase:firebase-auth")
////    implementation("com.google.android.gms:play-services-auth:20.7.0")
////}
//
//dependencies {
//    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")
//    implementation("androidx.core:core-ktx:1.10.1")
//    implementation("androidx.appcompat:appcompat:1.6.1")
//    implementation("com.google.android.material:material:1.9.0")
//    implementation("androidx.activity:activity-ktx:1.7.2")
//
//    // Required for Flutter embedding
//    implementation(project(":flutter"))
//
//plugins {
//    id("com.android.application")
//    id("org.jetbrains.kotlin.android")
//    id("com.google.gms.google-services")
//    id("dev.flutter.flutter-gradle-plugin")
//
//}
//
//flutter {
//    source = "../.."
//}
//android {
//    namespace = "com.example.visual_learning"
//    compileSdk = 35
//    ndkVersion = "27.0.12077973"
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = "11"
//    }
//
//    defaultConfig {
//        applicationId = "com.example.visual_learning"
//        minSdk = 23
//        targetSdk = 35
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    buildTypes {
//        release {
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//}
//
//dependencies {
//    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")
//    implementation("androidx.core:core-ktx:1.10.1")
//    implementation("androidx.appcompat:appcompat:1.6.1")
//    implementation("com.google.android.material:material:1.9.0")
//    implementation("androidx.activity:activity-ktx:1.7.2")
//
//    // Firebase
//    implementation(platform("com.google.firebase:firebase-bom:32.7.3"))
//    implementation("com.google.firebase:firebase-auth")
//    implementation("com.google.android.gms:play-services-auth:20.7.0")
//
//}



plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
    id("kotlin-android")
}

android {
    namespace = "com.example.visual_learning"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.visual_learning"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")

        }
        dependencies {
            implementation("com.google.android.exoplayer:exoplayer:2.19.1")
        }

    }
}

flutter {
    source = "../.."
}

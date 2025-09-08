plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.app.visuallearning"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.app.visuallearning"
        minSdk = 23
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = "key0"
            keyPassword = "123456"
            storeFile = file("key.jks")
            storePassword = "123456"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")

            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.exoplayer:exoplayer:2.19.1")
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
//plugins {
//    id("com.android.application")
//    id("org.jetbrains.kotlin.android")
//    id("com.google.gms.google-services")
//    id("dev.flutter.flutter-gradle-plugin")
//    id("kotlin-android")
//}
//
//android {
//    namespace = "com.app.visuallearning"
//    compileSdk = 35
//    ndkVersion = "27.0.12077973"
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_1_8
//        targetCompatibility = JavaVersion.VERSION_1_8
//        isCoreLibraryDesugaringEnabled = true
//    }
//
//    kotlinOptions {
//        jvmTarget = "1.8"
//    }
//
//    defaultConfig {
//        applicationId = "com.app.visuallearning"
//        minSdk = 23
//        targetSdk = 35
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//
//    signingConfigs {
//        release {
//            keyAlias "key0"
//            keyPassword "123456"
//            storeFile file("android/app/key.jks") // Path to your keystore
//            storePassword "123456"
//        }
//    }
//
//    buildTypes {
//        release {
//            // Use the signing configuration defined above
//            signingConfig signingConfigs.release
//
//                    // Enable minification and resource shrinking (optional, can be disabled if you don’t need it)
//                    minifyEnabled true
//            shrinkResources true
//
//            // Proguard configuration (optional, can be customized or disabled)
//            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
//        }
//    }
//
//    dependencies {
//        implementation("com.google.android.exoplayer:exoplayer:2.19.1")
//        coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
//    }
//}
//
//flutter {
//    source = "../.."
//}

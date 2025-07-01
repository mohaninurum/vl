//buildscript {
//    dependencies {
//        classpath("com.android.tools.build:gradle:8.2.2")
//        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.22")
//        classpath("com.google.gms:google-services:4.4.1")// ✅
//    }
//
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//
//allprojects {
//    repositories {
//
//        mavenCentral()
//    }
//}
//
//val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}


// android/build.gradle.kts
//buildscript {
//    dependencies {
//        classpath("com.android.tools.build:gradle:8.7.0")
//        classpath("com.google.gms:google-services:4.4.1")
//        // Add any Firebase-related plugins here
//    }
//}

allprojects {
    repositories {
        google()
        mavenCentral()
        maven {
            url = uri("https://storage.googleapis.com/download.flutter.io") // ✅ Add this
        }
    }
}

// Fix for rootProject/buildDir
val rootBuildDir = file("../build")
rootProject.buildDir = rootBuildDir

subprojects {
    project.buildDir = file("$rootBuildDir/${project.name}")
}

// Fix for "Delete" task
tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}



//buildscript {
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//        maven {
//            url = uri("https://storage.googleapis.com/download.flutter.io") // ✅ Add this
//        }
//    }
//
//    dependencies {
//        classpath("com.android.tools.build:gradle:8.2.2")
////        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.22")
//        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.8.22")
//        classpath("com.google.gms:google-services:4.4.1")
//    }
//}



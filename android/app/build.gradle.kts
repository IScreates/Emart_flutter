// android/app/build.gradle.kts

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter plugin must come AFTER Android and Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    // ✅ Google Services plugin for Firebase
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.myapp"
    compileSdk = 36 // ✅ Use 34 for stability (36 is not final yet)

    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.example.myapp"
        minSdk = flutter.minSdkVersion // ✅ Firebase requires at least SDK 21
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

  buildTypes {
    getByName("release") {
        // Disable resource shrinking since code shrinking is off
        isMinifyEnabled = false
        isShrinkResources = false

        // ✅ Prevent crash if no signing config
        signingConfig = signingConfigs.getByName("debug")
    }

    getByName("debug") {
        isMinifyEnabled = false
        isShrinkResources = false
    }
}

}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib")

    // ✅ Firebase BOM - keeps all Firebase libraries in sync
    implementation(platform("com.google.firebase:firebase-bom:33.5.1"))

    // ✅ Add Firebase SDKs you’re actually using:
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("com.google.firebase:firebase-storage")
}

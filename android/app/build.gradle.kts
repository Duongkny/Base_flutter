
plugins {
    id("com.android.application")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.homelove.homelove"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17

        // Enable Core Library Desugaring
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        applicationId = "com.homelove.homelove"

        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// Core Library Desugaring
dependencies {
    coreLibraryDesugaring(
        "com.android.tools:desugar_jdk_libs:2.1.4"
    )
}

flutter {
    source = "../.."
}

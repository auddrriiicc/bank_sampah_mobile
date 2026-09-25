allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// PERBAIKAN: Memaksa SDK 36 langsung pada tahap konfigurasi proyek (bebas dari error afterEvaluate)
subprojects {
    plugins.withId("com.android.application") {
        configure<com.android.build.gradle.BaseExtension> {
            compileSdkVersion(36)
        }
    }
    plugins.withId("com.android.library") {
        configure<com.android.build.gradle.BaseExtension> {
            compileSdkVersion(36)
        }
    }
}
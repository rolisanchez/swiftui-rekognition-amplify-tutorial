//
//  SwiftUIAmplifyRekognitionTutorialApp.swift
//  SwiftUIAmplifyRekognitionTutorial
//
//  Created by Victor Rolando Sanchez Jara on 12/1/20.
//

import SwiftUI
import Amplify
import AmplifyPlugins
import AWSPredictionsPlugin

@main
struct SwiftUIAmplifyRekognitionTutorialApp: App {
    // swiftlint:disable weak_delegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // swiftlint:enable weak_delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        print("didFinishLaunchingWithOptions")
        // Initialize Amplify
        initializeAWSAmplify()
        return true
    }

    func initializeAWSAmplify() {
        let authPlugin = AWSCognitoAuthPlugin()
        let predictionsPlugin = AWSPredictionsPlugin()
        do {
            try Amplify.add(plugin: authPlugin)
            try Amplify.add(plugin: predictionsPlugin)
            try Amplify.configure()
            print("Amplify initialized")
        } catch {
            fatalError("Failed to configure Amplify \(error)")
        }
    }
}

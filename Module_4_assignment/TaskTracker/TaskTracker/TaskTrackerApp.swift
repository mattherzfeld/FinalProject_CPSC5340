//
//  TaskTrackerApp.swift
//  TaskTracker
//  mrh0115@auburn.edu
//  Created by user239896 on 6/17/23.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct TaskTrackerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
        }
    }
}

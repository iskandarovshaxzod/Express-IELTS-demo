//
//  AppDelegate.swift
//  Express IELTS
//
//  Created by Iskandarov shaxzod on 22.11.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let visualEffectView = UIVisualEffectView()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UserViewController()
        window?.makeKeyAndVisible()
        UINavigationController().navigationItem.backBarButtonItem = UIBarButtonItem(title: "nazad",                                             style: .plain, target: nil, action: nil)
//        UINavigationItem().backBarButtonItem = UIBarButtonItem(title: "nazad", style: .plain,
//                                                               target: nil, action: nil)
        
        checkUserMode()
        configureNavigationBar()
        
        //MARK: Firebase configs
        FirebaseApp.configure()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        showBlur()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        hideBlur()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        hideBlur()
    }
    
}

// MARK: Methods

extension AppDelegate {
    
    func checkUserMode() {
        switch Database.shared.userMode {
            case .system: window?.overrideUserInterfaceStyle = .unspecified
            case .dark:   window?.overrideUserInterfaceStyle = .dark
            case .light:  window?.overrideUserInterfaceStyle = .light
        }
    }
    
    func showBlur() {
        if let window{
            if !visualEffectView.isDescendant(of: window) {
                visualEffectView.effect = UIBlurEffect(style: .light)
                visualEffectView.frame  = window.bounds
                window.addSubview(visualEffectView)
            }
        }
    }
    
    func hideBlur() {
        visualEffectView.removeFromSuperview()
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor  = "cl_main_back".color //.lightGray.withAlphaComponent(0.1)
        appearance.backgroundEffect = UIBlurEffect(style: .light)
        
        let scrollingAppearance = UINavigationBarAppearance()
        scrollingAppearance.configureWithTransparentBackground()
        scrollingAppearance.backgroundColor  = "cl_main_back".color //.lightGray.withAlphaComponent(0.1)
        scrollingAppearance.backgroundEffect = UIBlurEffect(style: .light)
        
        UINavigationBar.appearance().standardAppearance   = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollingAppearance
        UINavigationBar.appearance().compactAppearance    = scrollingAppearance
        UINavigationBar.appearance().isTranslucent        = false
    }
}

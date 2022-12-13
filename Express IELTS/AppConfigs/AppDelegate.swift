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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UserViewController()
        window?.makeKeyAndVisible()
        
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

    
    // MARK: Methods
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .lightGray.withAlphaComponent(0.1)
//        appearance.backgroundColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 0.1)
        appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialLight) // or dark
        
        let scrollingAppearance = UINavigationBarAppearance()
        scrollingAppearance.configureWithTransparentBackground()
        scrollingAppearance.backgroundColor = .lightGray.withAlphaComponent(0.1)
//        scrollingAppearance.backgroundColor = UIColor(red: 2/255, green: 3/255, blue: 148/255, alpha: 0.1)
        scrollingAppearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialLight)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = scrollingAppearance
        UINavigationBar.appearance().compactAppearance = scrollingAppearance
    }
}


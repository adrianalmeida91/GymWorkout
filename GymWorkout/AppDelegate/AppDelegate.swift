//
//  AppDelegate.swift
//  GymWorkout
//
//  Created by Adrian de Almeida on 02/09/19.
//  Copyright © 2019 Adrian de Almeida. All rights reserved.
//

import UIKit
import Swinject
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let container: Container = {
        let container = Container()
        // Injection
        // ViewModels
        container.autoregister(WorkoutViewModel.self, initializer: WorkoutViewModel.init)
        container.autoregister(WorkoutCreateViewModel.self, initializer: WorkoutCreateViewModel.init)

        // ViewControllers
        container.register(WorkoutViewController.self) { _ in
            let controller = R.storyboard.storyboard().instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
            controller.viewModel = container ~> WorkoutViewModel.self
            return controller
        }
        container.register(WorkoutCreateViewController.self) { _ in
            let controller = R.storyboard.storyboard().instantiateViewController(withIdentifier: "WorkoutCreateViewController") as! WorkoutCreateViewController
            controller.viewModel = container ~> WorkoutCreateViewModel.self
            return controller
        }

        // Services
        container.autoregister(DatabaseService.self, initializer: DatabaseService.init)
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Thread.sleep(forTimeInterval: 3.0)
        // Override point for customization after application launch.
        setupWindowInjection()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func setupWindowInjection() {
        let workoutViewController = container ~> WorkoutViewController.self
        let navigationController = UINavigationController(rootViewController: workoutViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

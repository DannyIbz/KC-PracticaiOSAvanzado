//
//  AppDelegate.swift
//  HackerBooksLite
//
//  Created by Fernando Rodríguez Romero on 7/12/16.
//  Copyright © 2016 KeepCoding. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
    var window: UIWindow?
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Clean up all local caches
        AsyncData.removeAllLocalFiles()
        
        // Create the window
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // Create the model
        let container = persistentContainer(dbName: "Model") { (error: NSError?) in
            fatalError("Unresolved error \(error), \(error?.userInfo)")
        }
        
        self.context = container.viewContext
        //injectContextToFirstViewController()

        
        func applicationDidEnterBackground(_ application: UIApplication) {
            guard let context = self.context else { return }
            saveContext(context: context)
        }
        
        //func injectContextToFirstViewController(){
        //    if let navController = window?.rootViewController as? UINavigationController,
        //        let initialViewController = navController.topViewController as? NotebooksController {
        //
        //        initialViewController.context = self.context
        //    }
        //}
        
        
        // Create the rootVC
        let rootVC = LibraryViewController(model: model!, style: .plain)
        window?.rootViewController = rootVC.wrappedInNavigationController()
        
        // Display
        window?.makeKeyAndVisible()
        
        return true
    }
}


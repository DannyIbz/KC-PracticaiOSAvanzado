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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let container = persistentContainer(dbName: "Model") { (error: NSError?) in
            fatalError("Unresolved error \(error), \(error?.userInfo)")
        }
        
        self.context = container.viewContext
        // injectContextToFirstViewController()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        guard let context = self.context else { return }
        saveContext(context: context)
    }
    
    // func injectContextToFirstViewController(){
    //    if let navController = window?.rootViewController as? UINavigationController,
    //        let initialViewController = navController.topViewController as? BookViewController {
    //
    //        initialViewController.context = self.context
    //    }
    // }
}


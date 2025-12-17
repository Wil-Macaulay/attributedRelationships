//
//  AppDelegate.swift
//  attributedRelationships
//
//  Created by wil macaulay on 2025-12-13.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        makeTestData()
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "attributedRelationships")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - test data support
    
    // remove the persistent store
    func clearTestData () {
        
    }
    
    func makeTestData () {
        let context = persistentContainer.viewContext
        let test1 = TDMTune.makeInstance(context: context, displayName: "first test tune", notes: "no notes")
        let test2 = TDMTune.makeInstance(context: context, displayName: "second test tune", notes: "some notes")
        let test3 = TDMTune.makeInstance(context: context, displayName: "third test tune", notes: "some more notes")

        let testSet = TDMTuneSet.makeInstance(context: context, displayName: "first test set", notes: "test set notes") as! TDMTuneSet
        let testSet2 = TDMTuneSet.makeInstance(context: context, displayName: "second test set", notes: "test set 2 notes") as! TDMTuneSet
        testSet.tunes = [test3,test2, test1]
        testSet2.tunes = [test1, test2]
        
        let collection1 = TDMCollection.makeInstance(context: context, displayName: "myCollection")
        collection1.items = [test1,testSet2]
        saveContext()
            
        
    }
    
    class var sharedDelegate :  AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate as AppDelegate
    }

}


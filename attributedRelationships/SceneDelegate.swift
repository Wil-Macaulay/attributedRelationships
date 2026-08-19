//
//  SceneDelegate.swift
//  tabbartest
//
//  Created by wil macaulay on 2025-11-07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        configureViewControllers(scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func configureViewControllers(_ scene: UIScene){
        print("configureViewControllers")
        // tab bar controller is on the top level
        if let rootVC = (window?.rootViewController)! as? UITabBarController{
            configureTabs(rootVC)
            
        }
        
    }
    
    func configureTabs(_ tabBarController : UITabBarController){
        print("--configureTabs")
        print("--- got tabBarController")
        
        
         
         
        tabBarController.tabs =
        [
            UITab(title:"Tunes", image: UIImage(systemName: "music.note.house"), identifier: "tabs.library"){ _ in
                self.libraryBrowser()
            },
            UITab(title:"Collections", image: UIImage(systemName: "books.vertical"), identifier: "tabs.collections"){ _ in
                self.collectionsBrowser()
            },
            UITab(title:"Sets", image: UIImage(systemName: "music.note.square.stack"), identifier: "tabs.sets"){ _ in
                self.setsBrowser()
            },

            UITab(title:"Tools", image: UIImage(systemName: "gearshape"), identifier: "tabs.tools"){ tab in
                self.toolsVC(tab: tab)
            },

        ]
        
        tabBarController.mode = .tabSidebar

    }
    
    func toolsVC(tab: UITab) -> UIViewController{
        print("toolsVC for tab \(tab)")
        let title = tab.identifier
        let leafVC = LeafViewController()
        leafVC.title = title
        let navController = UINavigationController(rootViewController: leafVC)
        leafVC.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Import", style: .plain, target: self, action: #selector(importJson))

        print("--- returning navController for " + title)
        return navController

    }
    
    @IBAction func importJson(){
        let abcTunes = AbcTune.importFromJsonFile("tunesData")
        let abcSets = AbcTuneSet.importFromJsonFile("tuneSets")
        let abcCollections = AbcCollection.importFromJsonFile("collections")
        print("collections \(abcCollections)")
    }
    
    func setsBrowser()->UIViewController {
        let splitVC = UISplitViewController(style: .doubleColumn)
        let setsVC = TuneSetTableViewController()
        splitVC.setViewController(setsVC, for: .primary)
        splitVC.setViewController(LeafViewController(), for: .secondary)
        return splitVC
    }
    
    func libraryBrowser()->UIViewController {
        let splitVC = UISplitViewController(style: .doubleColumn)
        let libraryVC = TuneTableViewController()
        splitVC.setViewController(libraryVC, for: .primary)
        splitVC.setViewController(LeafViewController(), for: .secondary)
        return splitVC
    }

    func collectionsBrowser()->UIViewController {
        let splitVC = UISplitViewController(style: .doubleColumn)
        let libraryVC = CollectionsTableViewController()
        splitVC.setViewController(libraryVC, for: .primary)
        splitVC.setViewController(LeafViewController(), for: .secondary)
        return splitVC
    }

}


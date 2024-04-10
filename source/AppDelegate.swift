//
//  AppDelegate.swift
//  HelloWorld
//
//  Created by Loïc DAVID on 11/06/2018.
//  Copyright © 2018 Meteo Trebeurden. All rights reserved.
//

import UIKit

// pour que le upside down fonctionne (sauf sur iPhone X à cause d'un bug)
extension UINavigationController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}
extension UITabBarController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}
extension UITableViewController {
    override open var supportedInterfaceOrientations : UIInterfaceOrientationMask     {
        return .all
    }
}

// nom des notifications
extension Notification.Name {
    static let historiqueSupprime = Notification.Name("historiqueSupprime")
    static let statistiqueSupprime = Notification.Name("statistiqueSupprime")
}

extension UIViewController {
    static var controllerName: String = ""
}

// application
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
        print("didFinishLaunchingWithOptions - AppDelegate")
        #endif

        // le contexte global pour stocker les paramètres de la session est créé dans Tirage.swift avec ce code :
        //     let choixUtilisateur = UserDefaults.standard

        // récupération du tableau des tirages sauvegardés (pour récupérer les choix utilisateurs) s'il existe, sinon initialisation du tableau
        recupererTirage()
        
        // récupération de l'historique des tirages sauvegardés si ils existent
        recupererHistorique()
        
        // récupération des statistiques des tirages sauvegardés si elles existent, sinon initialisation des statistiques
        recupererStatistique()
       
        return true
    }

    // sauvegarde le contexte utilisateur, les historique et les statistiques des tirages
    func sauverContexte() {
        #if DEBUG
        print("sauverContexte - AppDelegate")
        #endif
        
        sauvegarderTirage()
        sauvegarderHistorique()
        sauvegarderStatistique()
        
        // écriture sur le disque du contexte (en principe par nécessaire d'après la doc Apple)
        //choixUtilisateur.synchronize()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        #if DEBUG
        print("applicationDidEnterBackground - AppDelegate")
        #endif

        sauverContexte()
        
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
        #if DEBUG
        print("applicationWillTerminate - AppDelegate")
        #endif
        
        sauverContexte()
    }
 
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        #if DEBUG
        print("applicationDidReceiveMemoryWarning - AppDelegate")
        #endif
        
        let alert = UIAlertController(title: NSLocalizedString("memoireSaturee", comment: "Mémoire saturée"), message: NSLocalizedString("validationMemoirePleine", comment: "Voulez-vous videz la mémoire"), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationOui", comment: "oui"), style: .cancel, handler: { action in effacerTousHistorique() }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("validationNon", comment: "non"), style: .default, handler: nil))
        self.window?.rootViewController?.present(alert, animated: true)
    }
}


//
//  Created by Shady
//  All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coredatastore = try! CoreDataStore(storeName: "Store.sqlite")

        testInsertUser(coredatastore)
        testRetrieveUser(coredatastore)

        return true
    }

    func testInsertUser(_ coredatastore:CoreDataStore){
        coredatastore.insert(user: LocalUser.init(name: "helloe", imageName: "ddd", lastMessage: LocalMessage(body: "ddd", date: Date(), isMyMessage: true))) { (result) in
            switch result {
            case .success():
                debugPrint("testInsertUser success")
            case.failure(let error):
                debugPrint("testInsertUser error \(error)")
            }
        }
    }

    func testRetrieveUser(_ coredatastore:CoreDataStore){
        coredatastore.retrieveAllUsers { (result) in
            switch result {
            case .success(let users):
                debugPrint("testRetrieveUser success \(users.count)")
            case.failure(let error):
                debugPrint("testRetrieveUser error \(error)")
            }
        }
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


}


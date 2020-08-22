//
//  Created by Shady
//  All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let coredatastore = try! CoreDataStore(storeName: "Store.sqlite")

        //        testInsertUser(coredatastore)
        //        testRetrieveUser(coredatastore)
        let chat = testInsertChat(coredatastore)
        testRetrieveChat(coredatastore ,id:chat.id)
//        testUpdateMessages(coredatastore,chat)
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

    func insertUser(_ coredatastore:CoreDataStore,user:LocalUser){
        coredatastore.insert(user: user) { (result) in
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

    func testInsertChat(_ coredatastore:CoreDataStore) -> LocalChat{
        let localMsg1 = LocalMessage(body: "mesage1", date: Date(), isMyMessage: true)
        let localMsg2 = LocalMessage(body: "mesage2", date: Date(), isMyMessage: true)
        let localUser = LocalUser.init(name: "Name", imageName: "image Name", lastMessage: localMsg2)
        let localChat = LocalChat(id: UUID(), user: localUser, messages: [localMsg1,localMsg2], date: Date())

        coredatastore.insert(chat: localChat) { (result) in
            switch result {
            case .success():
                debugPrint("testInsertChat success")
            case.failure(let error):
                debugPrint("testInsertChat error \(error)")
            }
        }
        return localChat
    }

    func testRetrieveChat(_ coredatastore:CoreDataStore,id : UUID){
        coredatastore.retrieveChat(id: id) { (result) in
            switch result {
            case .success(let chat):
                debugPrint("testRetriveChat success \(chat)")
            case.failure(let error):
                debugPrint("testRetriveChat error \(error)")
            }
        }
    }

    func testUpdateMessages(_ coredatastore:CoreDataStore, _ chat : LocalChat){
        var newChat = chat
        newChat.messages.append(LocalMessage(body: "new body", date: Date(), isMyMessage: false))
        coredatastore.update(localChat: newChat) { (result) in
            switch result {
            case .success(let chat):
                debugPrint("testUpdateMessages success \(chat)")
            case.failure(let error):
                debugPrint("testUpdateMessages error \(error)")
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


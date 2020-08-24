//
//  Created by Shady
//  All rights reserved.
//  

import UIKit

struct UserViewComposer {
    static func create() -> UsersViewController{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
        let store = try! CoreDataStore(storeName: "Store.sqlite")
        let userFeautres  = LocalUserFeatures(store)
        setupModel(with: userFeautres, for: vc)
        return vc
    }
}
//MARK: Helpers methods
extension UserViewComposer {
    static func setupModel(with userFeature : LocalUserFeatures, for vc:UsersViewController){
        userFeature.retrieveAllUsers(completion: { result in
            switch result {
            case.success(let localUsers) :
                localUsers.isEmpty ? generateUsers(userFeature,vc: vc) :         setupViewControllerModel(viewController: vc, users: localUsers, userFeature: userFeature)

            case.failure(let error):
                debugPrint("error in retriveing user from db \(error)")
            }
        })
    }

    static private func generateUsers(_ userFeature : LocalUserFeatures, vc:UsersViewController){
        let users = UserGenerator.generateUsers()
        for user in users{
            userFeature.save(user: user, completion: {(result) in
                switch result {
                case.success :
                    debugPrint("success")
                case.failure(let error):
                    debugPrint("error in save from db \(error)")
                }
            })
        }
        setupViewControllerModel(viewController:vc, users: users.map{$0.local}, userFeature:userFeature)
    }
    static private func setupViewControllerModel(viewController:UsersViewController, users :[LocalUser], userFeature:LocalUserFeatures){
        viewController.userFeautres = userFeature
        viewController.model = users.map{$0.model}
    }

}

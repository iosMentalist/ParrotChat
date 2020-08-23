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

    //MARK: Helpers methods
    static func setupModel(with userFeature : LocalUserFeatures, for vc:UsersViewController){
        userFeature.retrieveAllUsers(completion: { result in
            switch result {
            case.success(let localUsers) :
                localUsers.isEmpty ? generateUsers(userFeature,vc: vc) :         setupViewControllerModel(for: vc, with: localUsers)

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
        setupViewControllerModel(for: vc, with: users.map{$0.local})
    }
    static private func setupViewControllerModel(for vc:UsersViewController,with users:[LocalUser]){
        vc.model = users.map{$0.model}
    }

}

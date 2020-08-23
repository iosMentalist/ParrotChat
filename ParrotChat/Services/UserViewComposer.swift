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
        vc.userFeature = userFeautres
        return vc
    }
}

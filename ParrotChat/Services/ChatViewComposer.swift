//
//  Created by Shady
//  All rights reserved.
//  

import UIKit

struct ChatViewComposer {
    static func create(userFeatures:LocalUserFeatures,user:User) -> ChatDetailViewController{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatDetailViewController") as! ChatDetailViewController
        vc.userFeatures = userFeatures
        vc.user = user
        return vc
    }
}

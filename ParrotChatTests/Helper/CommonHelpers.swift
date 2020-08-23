//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
import ParrotChat


//helper function that sends back the same user for model and local boundaires
func anyUser() -> (model:User,local:LocalUser){
    let model =  User(id: UUID(), name: "user name", imageName: "image", chat: nil)

    let local =  LocalUser(id: UUID(), name: "user name", imageName: "image", chat: nil)

    return(model,local)
}

func anyError() -> NSError{
    return NSError(domain: "", code: 1, userInfo: nil)

}

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
import ParrotChat


//helper function that sends back the same user for model and local boundaires
func anyUser() -> (model:User,local:LocalUser){
    let model =  User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))

    let local =  LocalUser(name: "user name", imageName: "image", lastMessage: LocalMessage(body: "body", date: Date(), isMyMessage: true))

    return(model,local)
}

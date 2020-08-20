//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public struct User {
    var name : String
    var imageName : String
    var lastMessage : Message

    public init(name:String,imageName:String,lastMessage:Message){
        self.name = name
        self.imageName = imageName
        self.lastMessage = lastMessage
    }
}

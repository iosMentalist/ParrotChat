//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public struct LocalUser : Equatable{
    public static func == (lhs: LocalUser, rhs: LocalUser) -> Bool {
        return lhs.name == rhs.name
    }

    var name : String
    var imageName : String
    var chat : LocalChat?

    public init(name:String,imageName:String,chat:LocalChat?){
        self.name = name
        self.imageName = imageName
        self.chat = chat
    }
}

extension User{
    var local : LocalUser{
        return LocalUser(name: self.name, imageName: self.imageName, chat: self.chat?.local ?? nil)
    }
}

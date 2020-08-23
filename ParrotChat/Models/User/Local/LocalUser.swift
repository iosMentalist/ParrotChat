//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public struct LocalUser : Equatable{
    public static func == (lhs: LocalUser, rhs: LocalUser) -> Bool {
        return lhs.name == rhs.name
    }
    var id : UUID
    var name : String
    var imageName : String
    var chat : LocalChat?

    public init(id:UUID,name:String,imageName:String,chat:LocalChat?){
        self.id = id
        self.name = name
        self.imageName = imageName
        self.chat = chat
    }
}

extension User{
    var local : LocalUser{
        return LocalUser(id: self.id, name: self.name, imageName: self.imageName, chat: self.chat?.local ?? nil)
    }
}
extension LocalUser{
    var model : User{
        return User(id: self.id, name: self.name, imageName: self.imageName, chat: self.chat?.model ?? nil)
    }
}

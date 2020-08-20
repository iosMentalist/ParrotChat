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
    var lastMessage : LocalMessage
}

extension User{
    func toLocal() -> LocalUser{
        return LocalUser(name: self.name, imageName: self.imageName, lastMessage: self.lastMessage.toLocal())
    }
}

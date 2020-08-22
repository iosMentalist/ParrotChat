//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

let NUMBER_OF_USERS = 200

final class UserGenerator{
    static func generateUsers() -> [User]{
        var users = [User]()
        for i in 1...200{
            users.append(User(name: "User \(i)", imageName: "", chat: nil))
        }
        return users
    }
}

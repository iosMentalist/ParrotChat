//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

let NUMBER_OF_USERS = 200

final class UserGenerator{
    static func generateUsers() -> [User]{
        var users = [User]()
        for i in 1...NUMBER_OF_USERS{
            users.append(User(id: UUID(), name: "User \(i)", imageName: (i % 2 == 0) ? "profile1.jpg" : "profile2.jpg", chat: nil))
        }
        return users
    }
}

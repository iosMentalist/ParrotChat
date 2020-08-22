//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public struct User {
    var name : String
    var imageName : String
    var chat : Chat?

    public init(name:String,imageName:String,chat:Chat?){
        self.name = name
        self.imageName = imageName
        self.chat = chat
    }
}

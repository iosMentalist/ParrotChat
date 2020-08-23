//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public struct User {
    var id : UUID
    var name : String
    var imageName : String
    var chat : Chat?

    public init(id:UUID,name:String,imageName:String,chat:Chat?){
        self.id = id
        self.name = name
        self.imageName = imageName
        self.chat = chat
    }
}

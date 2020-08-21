//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public struct Chat  {
    var id : UUID
    var user : User
    var messages : [Message]
    var date : Date

    public init(id:UUID,user:User,messages:[Message],date:Date){
          self.id = id
          self.user = user
          self.messages = messages
          self.date = date
      }
}

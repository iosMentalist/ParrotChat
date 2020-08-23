//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public struct Chat  {
    var messages : [Message]
    var date : Date

    public init(messages:[Message],date:Date){
          self.messages = messages
          self.date = date
      }
}

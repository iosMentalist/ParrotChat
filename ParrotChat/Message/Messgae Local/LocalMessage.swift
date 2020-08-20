//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

struct LocalMessage {
    var body : String
    var date : Date
    var isMyMessage : Bool
}

extension Message{
    func toLocal() -> LocalMessage{
        return LocalMessage(body: self.body, date: self.date, isMyMessage: self.isMyMessage)
    }
}

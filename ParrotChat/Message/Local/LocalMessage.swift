//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public struct LocalMessage {
    var body : String
    var date : Date
    var isMyMessage : Bool
    
    public init(body:String,date:Date,isMyMessage:Bool){
        self.body = body
        self.date = date
        self.isMyMessage = isMyMessage
    }
}

extension Message{
    func toLocal() -> LocalMessage{
        return LocalMessage(body: self.body, date: self.date, isMyMessage: self.isMyMessage)
    }

}

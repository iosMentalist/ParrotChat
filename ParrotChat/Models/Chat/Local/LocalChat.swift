//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public struct LocalChat {
    var messages : [LocalMessage]
    var date : Date
    
    public init(messages:[LocalMessage],date:Date){
        self.messages = messages
        self.date = date
    }
}

extension Chat{
    var local : LocalChat{
        return LocalChat(messages: self.messages.map{$0.toLocal()}, date: self.date)
    }
}

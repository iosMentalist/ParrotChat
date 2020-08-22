//
//  Created by Shady
//  All rights reserved.
//  

import CoreData

@objc(ManagedChat)
class ManagedChat: NSManagedObject {
    @NSManaged var messages: NSOrderedSet
    @NSManaged var date: Date
}

extension ManagedChat {
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedChat {
        return ManagedChat(context: context)
    }

    var local : LocalChat{
        let managedMessages : [ManagedMessage] = self.messages.array as! [ManagedMessage]
        return LocalChat(messages: managedMessages.map{$0.local}, date: self.date)
    }
}

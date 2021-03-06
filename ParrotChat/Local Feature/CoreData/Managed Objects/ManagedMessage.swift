//
//  Created by Shady
//  All rights reserved.
//  
import CoreData
//
@objc(ManagedMessage)
class ManagedMessage: NSManagedObject {
    @NSManaged var body: String
    @NSManaged var date: Date
    @NSManaged var isMyMessage: Bool
}

extension ManagedMessage {
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedMessage {
        return ManagedMessage(context: context)
    }
}


extension ManagedMessage {
    static func newInstanceFromLocal(_ localMsg : LocalMessage,in context: NSManagedObjectContext) -> ManagedMessage{
        let managedMsg = try! ManagedMessage.newUniqueInstance(in: context)
        managedMsg.body = localMsg.body
        managedMsg.date = localMsg.date
        managedMsg.isMyMessage = localMsg.isMyMessage
        return managedMsg
    }

    var local : LocalMessage{
        return LocalMessage(body: self.body, date: self.date, isMyMessage: self.isMyMessage)
    }

    static func newManagedMessageFrom(local:LocalMessage,in context: NSManagedObjectContext) -> ManagedMessage{
        let managedMsg = try! ManagedMessage.newUniqueInstance(in: context)
        managedMsg.body = local.body
        managedMsg.date = local.date
        managedMsg.isMyMessage = local.isMyMessage
        return managedMsg
    }

    static func managedMessages(from localMessages: [LocalMessage], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: localMessages.map{
            return ManagedMessage.newInstanceFromLocal($0, in: context)
        })
    }
}



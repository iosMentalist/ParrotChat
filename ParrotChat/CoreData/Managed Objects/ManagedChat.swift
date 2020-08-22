//
//  Created by Shady
//  All rights reserved.
//  

import CoreData

@objc(ManagedChat)
class ManagedChat: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var user: ManagedUser
    @NSManaged var messages: NSOrderedSet
    @NSManaged var date: Date
}

extension ManagedChat {
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedChat {
        return ManagedChat(context: context)
    }

    static func find(context: NSManagedObjectContext) throws -> [ManagedChat]? {
        let request = NSFetchRequest<ManagedChat>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }

    var local : LocalChat{
        let managedMessages : [ManagedMessage] = self.messages.array as! [ManagedMessage]
        return LocalChat(id: self.id, user: self.user.local, messages: managedMessages.map{$0.local}, date: self.date)
       }
}

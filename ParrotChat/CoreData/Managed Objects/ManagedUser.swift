//
//  Created by Shady
//  All rights reserved.
//  
import CoreData

@objc(ManagedUser)
class ManagedUser: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var imageName: String
    @NSManaged var lastMessage: ManagedMessage?
}

extension ManagedUser {
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedUser {
        return ManagedUser(context: context)
    }

    static func find(context: NSManagedObjectContext) throws -> [ManagedUser]? {
        let request = NSFetchRequest<ManagedUser>(entityName: entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }

    var local : LocalUser{
        return LocalUser(name: self.name, imageName: self.imageName, lastMessage: self.lastMessage?.local ?? nil)
    }

    static func newManagedUserFrom(local:LocalUser, in context: NSManagedObjectContext) -> ManagedUser{
        let managedUser = try! ManagedUser.newUniqueInstance(in: context)
        managedUser.imageName  = local.imageName
        managedUser.name  = local.name
        if let msg = local.lastMessage{
            managedUser.lastMessage = ManagedMessage.newInstanceFromLocal(msg, in: context)
        }
        return managedUser
    }
}


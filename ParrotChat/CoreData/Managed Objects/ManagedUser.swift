//
//  Created by Shady
//  All rights reserved.
//  
import CoreData
@objc(ManagedUser)
class ManagedUser: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var imageName: String
    @NSManaged var lastMessage: ManagedMessage
}


extension ManagedUser {
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedUser {
        return ManagedUser(context: context)
    }
}

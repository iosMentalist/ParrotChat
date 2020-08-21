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

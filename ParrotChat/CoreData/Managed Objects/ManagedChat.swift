//
//  Created by Shady
//  All rights reserved.
//  

import CoreData

@objc(ManagedChat)
class ManagedChat: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var user: ManagedUser
    @NSManaged var messages: [ManagedMessage]
    @NSManaged var date: Date
}

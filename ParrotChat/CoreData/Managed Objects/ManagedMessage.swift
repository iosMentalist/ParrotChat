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

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserDeleter {
    typealias DeletionResult = Result<Void, Error>

    func delete(user:User,completion:@escaping(DeletionResult)->Void)
}

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserSaver {
    typealias InsertionResult = Result<Void, Error>

    func save(user:User,completion:@escaping(InsertionResult)->Void)
}

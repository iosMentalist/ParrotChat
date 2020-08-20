//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserStore{
    typealias InsertionCompletion =  (InsertionResult) -> Void
    typealias InsertionResult = Result<Void, Error>

    func insert(user:LocalUser, completion: @escaping InsertionCompletion)
}

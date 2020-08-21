//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserStore{
    typealias InsertionCompletion =  (InsertionResult) -> Void
    typealias InsertionResult = Result<Void, Error>

    typealias RetrieveResult = Result<[LocalUser],Error>
    typealias RetrieveCompletion = (RetrieveResult) -> Void

    typealias DeletionCompletion =  (DeletionResult) -> Void
    typealias DeletionResult = Result<Void, Error>


    func insert(user:LocalUser, completion: @escaping InsertionCompletion)
    func retrieveAllUsers(completion:@escaping RetrieveCompletion)
    func delete(user:LocalUser, completion: @escaping DeletionCompletion)

}

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


    func insert(user:LocalUser, completion: @escaping InsertionCompletion)
    func retrieveAllUsers(completion:@escaping RetrieveCompletion)

}

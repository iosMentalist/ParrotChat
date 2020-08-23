//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserSaver {
    typealias InsertionResult = Result<Void, Error>

    func save(user:User,completion:@escaping(InsertionResult)->Void)
}

public protocol UserRetriever {

    typealias RetrieveUserResult = Result<[LocalUser],Error>
    typealias RetrieveCompletion = (RetrieveUserResult) -> Void

    func retrieveAllUsers(completion:@escaping RetrieveCompletion)
}

public protocol UserDeleter {
    typealias DeletionResult = Result<Void, Error>

    func delete(user:User,completion:@escaping(DeletionResult)->Void)
}

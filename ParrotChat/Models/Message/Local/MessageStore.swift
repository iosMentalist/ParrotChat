//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
public protocol MessageStore{
    typealias InsertionCompletion =  (InsertionResult) -> Void
    typealias InsertionResult = Result<Void, Error>

    typealias RetrieveResult = Result<[LocalMessage],Error>
    typealias RetrieveCompletion = (RetrieveResult) -> Void

    typealias DeletionCompletion =  (DeletionResult) -> Void
    typealias DeletionResult = Result<Void, Error>


    func insert(message:LocalMessage, completion: @escaping InsertionCompletion)
    func retrieveAllMessages(completion:@escaping RetrieveCompletion)
    func delete(message:LocalMessage, completion: @escaping DeletionCompletion)

}

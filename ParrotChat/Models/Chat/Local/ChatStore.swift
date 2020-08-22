//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
public protocol ChatStore{
    typealias InsertionCompletion =  (InsertionResult) -> Void
    typealias InsertionResult = Result<Void, Error>

    typealias RetrieveResult = Result<LocalChat,Error>
    typealias RetrieveChatCompletion = (RetrieveResult) -> Void

    typealias DeletionCompletion =  (DeletionResult) -> Void
    typealias DeletionResult = Result<Void, Error>


    typealias UpdateCompletion =  (UpdateResult) -> Void
    typealias UpdateResult = Result<Void, Error>

    func insert(chat:LocalChat, completion: @escaping InsertionCompletion)
    func retrieveChat(id:UUID,completion:@escaping RetrieveChatCompletion)
    func delete(chat:LocalChat, completion: @escaping DeletionCompletion)
    func update(localChat:LocalChat, completion: @escaping UpdateCompletion)

}

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
public protocol MessageSaver {
    typealias InsertionResult = Result<Void, Error>

    func save(message:Message,completion:@escaping(InsertionResult)->Void)
}

public protocol MessageRetriever {

    typealias RetrieveMessageResult = Result<[LocalMessage],Error>
    typealias RetrieveCompletion = (RetrieveMessageResult) -> Void

    func retrieveAllMessages(completion:@escaping RetrieveCompletion)
}

public protocol MessageDeleter {
    typealias DeletionResult = Result<Void, Error>

    func delete(message:Message,completion:@escaping(DeletionResult)->Void)
}


//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
public protocol ChatSaver {
    typealias InsertionResult = Result<Void, Error>

    func save(chat:Chat,completion:@escaping(InsertionResult)->Void)
}

public protocol ChatRetriever {

    typealias RetrieveChatResult = Result<LocalChat,Error>
    typealias RetrieveChatCompletion = (RetrieveChatResult) -> Void

    func retrieveChat(id:UUID,completion:@escaping RetrieveChatCompletion)
}

public protocol ChatDeleter {
    typealias DeletionResult = Result<Void, Error>

    func delete(chat:Chat,completion:@escaping(DeletionResult)->Void)
}


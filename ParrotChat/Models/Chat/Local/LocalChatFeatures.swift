//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public class LocalChatFeatures {

    let store : ChatStore

    public init(_ store:ChatStore){
        self.store = store
    }
}

extension LocalChatFeatures : ChatSaver {
    public func save(chat:Chat,completion:@escaping(InsertionResult)->Void){

        store.insert(chat: chat.local){[weak self] result in
            guard self != nil else { return }


            switch result {
            case .success(()):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension LocalChatFeatures : ChatRetriever {
    public func retrieveChat(id:UUID,completion: @escaping RetrieveChatCompletion) {
        store.retrieveChat(id:id) { [weak self] result in
             guard self != nil else {return}

             switch result {
             case .failure(let error):
                 completion(.failure(error))
             case .success(let chats):
                 completion(.success(chats))

             }
         }
     }
}

extension LocalChatFeatures : ChatDeleter {
     public func delete(chat:Chat,completion:@escaping(DeletionResult)->Void){

        store.delete(chat: chat.local){[weak self] result in
            guard self != nil else { return }


            switch result {
            case .success(()):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

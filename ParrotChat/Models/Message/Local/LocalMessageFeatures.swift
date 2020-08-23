//
//  Created by Shady
//  All rights reserved.
//

import Foundation

public class LocalMessageFeatures {

    let store : MessageStore

    public init(_ store:MessageStore){
        self.store = store
    }
}

extension LocalMessageFeatures : MessageSaver {
    public func save(message:Message,completion:@escaping(InsertionResult)->Void){

        store.insert(message: message.local){[weak self] result in
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

extension LocalMessageFeatures : MessageRetriever {
    public func retrieveAllMessages(completion: @escaping RetrieveCompletion) {
         store.retrieveAllMessages { [weak self] result in
             guard self != nil else {return}

             switch result {
             case .failure(let error):
                 completion(.failure(error))
             case .success(let messages):
                 completion(.success(messages))

             }
         }
     }
}

extension LocalMessageFeatures : MessageDeleter {
     public func delete(message:Message,completion:@escaping(DeletionResult)->Void){

        store.delete(message: message.local){[weak self] result in
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

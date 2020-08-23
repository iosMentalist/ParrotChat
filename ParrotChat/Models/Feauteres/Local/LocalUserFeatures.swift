//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public class LocalUserFeatures {
    let store : UserStore
    
    public init(_ store:UserStore){
        self.store = store
    }
}

extension LocalUserFeatures : UserSaver {
    public func save(user:User,completion:@escaping(InsertionResult)->Void){
        store.insert(user: user.local){[weak self] result in
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

extension LocalUserFeatures : UserRetriever {
    public func retrieveAllUsers(completion: @escaping RetrieveCompletion) {
         store.retrieveAllUsers { [weak self] result in
             guard self != nil else {return}
             switch result {
             case .failure(let error):
                 completion(.failure(error))
             case .success(let users):
                 completion(.success(users))
             }
         }
     }
}

extension LocalUserFeatures : UserDeleter {

     public func delete(user:User,completion:@escaping(DeletionResult)->Void){
        store.delete(user: user.local){[weak self] result in
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

extension LocalUserFeatures : UserUpdater {
     public func update(user:User,completion:@escaping(UpdaterResult)->Void){

        store.update(user: user.local){[weak self] result in
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

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public class LocalUserDeleter : UserDeleter {

    let store : UserStore

    public init(_ store:UserStore){
        self.store = store
    }

    public func delete(user:User,completion:@escaping(DeletionResult)->Void){

        store.delete(user: user.toLocal()){[weak self] result in
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

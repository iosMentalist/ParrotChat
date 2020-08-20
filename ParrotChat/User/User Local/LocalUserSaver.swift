//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public class LocalUserSaver : UserSaver {

    let store : UserStore

    public init(_ store:UserStore){
        self.store = store
    }

    public func save(user:User,completion:@escaping(InsertionResult)->Void){

        store.insert(user: user.toLocal()){[weak self] result in
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

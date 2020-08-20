//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
public class UserSaver {

    let store : UserStore
    typealias InsertionResult = Result<Void, Error>

    init(_ store:UserStore){
        self.store = store
    }

    func save(user:User,completion:@escaping(InsertionResult)->Void){
        store.insert(user: user.toLocal()){result in
            switch result {
            case .success(()):
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation


public class LocalUserRetriever : UserRetriever {

    let store : UserStore

    public init(_ store:UserStore){
        self.store = store
    }

    public func retrieveAllUsers(completion: @escaping RetrieveUserCompletion) {
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

//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
import ParrotChat

class UserStoreSpy : UserStore {

    enum ReceivedInvocation : Equatable{
        case insert(LocalUser)
        case retrieve
    }
    var receivedInvocations = [ReceivedInvocation]()

    private var insertionCompletions = [InsertionCompletion]()
    private var retrieveCompletions = [RetrieveCompletion]()

    //MARK: User Store implemention
    func insert(user: LocalUser, completion: @escaping InsertionCompletion)  {
        insertionCompletions.append(completion)
        receivedInvocations.append(.insert(user))
    }

    func retrieveAllUsers(completion: @escaping RetrieveCompletion) {
        retrieveCompletions.append(completion)
        receivedInvocations.append(.retrieve)
    }

    //MARK: Spy's insert functions
    func completeWithInsertionError(withError error: Error, at index:Int = 0){
        insertionCompletions[index](.failure(error))
    }

    func completeWithInsertionSuccess(user:LocalUser, at index:Int = 0){
        insertionCompletions[index](.success(()))
    }
    //MARK: Spy's retrive functions

    func completeWithRetrieveError(with error: Error, at index:Int = 0){
        retrieveCompletions[index](.failure(error))
    }

}

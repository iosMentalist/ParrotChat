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
        case delete
    }
    var receivedInvocations = [ReceivedInvocation]()

    private var insertionCompletions = [InsertionCompletion]()
    private var deletionCompletions = [DeletionCompletion]()
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

    func delete(user: LocalUser, completion: @escaping DeletionCompletion) {
        deletionCompletions.append(completion)
        receivedInvocations.append(.delete)
    }

    func update(user: LocalUser, completion: @escaping UpdateCompletion) {

    }

    //MARK: Spy's insert functions
    func completeWithInsertionError(with error: Error, at index:Int = 0){
        insertionCompletions[index](.failure(error))
    }

    func completeWithInsertionSuccess(user:LocalUser, at index:Int = 0){
        insertionCompletions[index](.success(()))
    }
    //MARK: Spy's retrive functions
    func completeWithRetrieveError(with error: Error, at index:Int = 0){
        retrieveCompletions[index](.failure(error))
    }

    func completeWithRetrieveSuccess(with users:[LocalUser], at index:Int = 0){
        retrieveCompletions[index](.success(users))
    }
    //MARK: Spy's delete functions
    func completeWithDeletionError(with error: Error, at index:Int = 0){
        deletionCompletions[index](.failure(error))
    }

    func completeWithDeletionSuccess(user:LocalUser, at index:Int = 0){
        deletionCompletions[index](.success(()))
    }

}

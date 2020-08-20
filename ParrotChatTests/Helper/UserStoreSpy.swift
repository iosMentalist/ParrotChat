//
//  Created by Shady
//  All rights reserved.
//  

import Foundation
import ParrotChat

   class UserStoreSpy : UserStore {
       enum ReceivedInvocation : Equatable{
           case insert(LocalUser)
       }
       var receivedInvocations = [ReceivedInvocation]()

       private var insertionCompletions = [InsertionCompletion]()

       //MARK: User Store implemention
       func insert(user: LocalUser, completion: @escaping InsertionCompletion)  {
           insertionCompletions.append(completion)
           receivedInvocations.append(.insert(user))
       }

       //MARK: Spy's functions
       func completeWithInsertionError(withError error: Error, at index:Int = 0){
           insertionCompletions[index](.failure(error))
       }

       func completeWithInsertionSuccess(user:LocalUser, at index:Int = 0){
           insertionCompletions[index](.success(()))
       }
   }

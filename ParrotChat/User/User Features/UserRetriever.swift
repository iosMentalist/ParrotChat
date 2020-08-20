//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

public protocol UserRetriever {

    typealias RetrieveUserResult = Result<[LocalUser],Error>
    typealias RetrieveCompletion = (RetrieveUserResult) -> Void

    func retrieveAllUsers(completion:@escaping RetrieveCompletion)
}

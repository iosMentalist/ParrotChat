// Copyright © 2020 Shady Kahaleh. All rights reserved.

import Foundation

extension CoreDataStore : UserStore {
    public func insert(user: LocalUser, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( InsertionResult{

                let  managedUser = try ManagedUser.newUniqueInstance(in: context)
                managedUser.name = user.name
                managedUser.imageName = user.imageName
                managedUser.lastMessage = ManagedMessage.newInstanceFromLocal(user.lastMessage, in: context)
                try context.save()
            })
        }
    }

    public func retrieveAllUsers(completion: @escaping RetrieveCompletion) {

    }

    public func delete(user: LocalUser, completion: @escaping DeletionCompletion) {

    }



}

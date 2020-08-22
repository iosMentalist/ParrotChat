// Copyright © 2020 Shady Kahaleh. All rights reserved.

import Foundation

extension CoreDataStore : UserStore {

    public func insert(user: LocalUser, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( InsertionResult{

                let  managedUser = try ManagedUser.newUniqueInstance(in: context)
                managedUser.name = user.name
                managedUser.imageName = user.imageName
                let chat = try ManagedChat.newUniqueInstance(in: context)
                chat.date = Date()
                managedUser.chat = chat
                try context.save()
            })
        }
    }

    public func retrieveAllUsers(completion: @escaping RetrieveCompletion) {
        perform { context in
            completion(Result {
                try ManagedUser.find(context: context)!.map {
                    return LocalUser(id: $0.id, name: $0.name, imageName: $0.imageName, chat: $0.chat?.local)
                }
            })
        }
    }

    public func delete(user: LocalUser, completion: @escaping DeletionCompletion) {

    }



}

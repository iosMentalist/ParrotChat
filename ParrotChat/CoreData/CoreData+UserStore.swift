// Copyright © 2020 Shady Kahaleh. All rights reserved.

import Foundation

extension CoreDataStore : UserStore {

    public func insert(user: LocalUser, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( InsertionResult{

                let  managedUser = try ManagedUser.newUniqueInstance(in: context)
                managedUser.name = user.name
                managedUser.imageName = user.imageName
                if let msg = user.lastMessage{
                managedUser.lastMessage = ManagedMessage.newInstanceFromLocal(msg, in: context)
                }
                let chat = try ManagedChat.newUniqueInstance(in: context)
                chat.date = Date()
                chat.id = UUID()
                chat.user = managedUser
                managedUser.chat = chat
                try context.save()
            })
        }
    }

    public func retrieveAllUsers(completion: @escaping RetrieveCompletion) {
        perform { context in
            completion(Result {
                try ManagedUser.find(context: context)!.map {
                    return LocalUser(name: $0.name, imageName: $0.imageName, lastMessage: $0.lastMessage?.local)
                }
            })
        }
    }

    public func delete(user: LocalUser, completion: @escaping DeletionCompletion) {

    }



}

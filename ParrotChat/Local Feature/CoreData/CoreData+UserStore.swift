// Copyright © 2020 Shady Kahaleh. All rights reserved.

import Foundation

extension CoreDataStore : UserStore {

    public func insert(user: LocalUser, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( Result{

                let  managedUser = try ManagedUser.newUniqueInstance(in: context)
                managedUser.name = user.name
                managedUser.id = user.id
                managedUser.imageName = user.imageName
                if let localChat = user.chat{
                    let chat = try ManagedChat.newUniqueInstance(in: context)
                    chat.date = Date()
                    chat.messages = ManagedMessage.managedMessages(from: localChat.messages, in: context)
                    managedUser.chat = chat
                }
                try context.save()
            })
        }
    }

    public func update(user: LocalUser, completion: @escaping UpdateCompletion) {
        perform { context in
            completion( Result{
                debugPrint("update \(user.id)")
                if let  managedUsers = try ManagedUser.first(id:user.id,context: context){
                    if let localChat = user.chat{
                        let chat = try ManagedChat.newUniqueInstance(in: context)
                        chat.date = Date()
                        chat.messages = ManagedMessage.managedMessages(from: localChat.messages, in: context)
                        managedUsers.first!.chat = chat
                    }
                    try context.save()
                }
                else{
                    debugPrint("fatal error : user couldnt be found in db : \(user)")
                }
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

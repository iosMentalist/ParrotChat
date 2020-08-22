//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

extension CoreDataStore : ChatStore {


    public func update(localChat: LocalChat, completion: @escaping UpdateCompletion) {
        self.append(localMessage: localChat.messages.last!, to: localChat, completion: completion)
    }

    private func append(localMessage: LocalMessage,to localChat: LocalChat, completion: @escaping UpdateCompletion) {
        perform { context in
            completion(Result {
                let managedChat = try ManagedChat.find(id:localChat.id,context: context)!.first!
                let  msg = ManagedMessage.newInstanceFromLocal(localMessage, in: context)
                var array = managedChat.messages.array as! [ManagedMessage]
                array.append(msg)
                managedChat.messages = NSOrderedSet(array: array)
                try context.save()
            })
        }
    }


    public func retrieveChat(id: UUID, completion: @escaping RetrieveChatCompletion) {
        perform { context in
            completion(Result {
                let chat = try ManagedChat.find(id:id,context: context)!.first!
                return LocalChat(id: chat.id, user: chat.user.local, messages: LocalMessage.localMessagesFrom(managedMessages: chat.messages.array as! [ManagedMessage]), date: chat.date)
            })
        }

    }

    public func delete(chat: LocalChat, completion: @escaping DeletionCompletion) {

    }

    public func insert(chat: LocalChat, completion: @escaping InsertionCompletion) {
        perform { context in
            completion( InsertionResult{
                let  managedChat = try ManagedChat.newUniqueInstance(in: context)
                managedChat.id = chat.id
                managedChat.date = chat.date
                managedChat.user = ManagedUser.newManagedUserFrom(local: chat.user, in: context)
                managedChat.messages = ManagedMessage.managedMessages(from: chat.messages, in: context)
                try context.save()
            })
        }
    }



}

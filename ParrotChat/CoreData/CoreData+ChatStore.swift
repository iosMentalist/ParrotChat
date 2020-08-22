//
//  Created by Shady
//  All rights reserved.
//  

import Foundation

extension CoreDataStore : ChatStore {
    public func retrieveChat(id: UUID, completion: @escaping RetrieveChatCompletion) {

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

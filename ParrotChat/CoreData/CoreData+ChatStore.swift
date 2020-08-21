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

                try context.save()
            })
        }
    }



}

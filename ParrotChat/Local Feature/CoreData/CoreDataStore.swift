//
//  Created by Shady
//  All rights reserved.
//

import Foundation
import CoreData

public final class CoreDataStore {

    private static let modelName = "Store"
    private static let model = NSManagedObjectModel.with(name: modelName, in: Bundle(for: CoreDataStore.self))

    private let container: NSPersistentContainer
    private let context: NSManagedObjectContext

    enum StoreError: Error {
        case modelNotFound
        case failedToLoadPersistentContainer(Error)
    }

    public init(storeName: String) throws {
        guard let model = CoreDataStore.model else {
            throw StoreError.modelNotFound
        }
        do {
            let url = NSPersistentContainer
            .defaultDirectoryURL().appendingPathComponent(storeName)
            debugPrint("core datastore \(url)")
            container = try NSPersistentContainer.load(name: CoreDataStore.modelName, model: model, url:url)
            context = container.newBackgroundContext()
        } catch {
            throw StoreError.failedToLoadPersistentContainer(error)
        }
    }

    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform { action(context) }
    }

    private func cleanUpReferencesToPersistentStores() {
        context.performAndWait {
            let coordinator = self.container.persistentStoreCoordinator
            try? coordinator.persistentStores.forEach(coordinator.remove)
        }
    }

    deinit {
        cleanUpReferencesToPersistentStores()
    }
}

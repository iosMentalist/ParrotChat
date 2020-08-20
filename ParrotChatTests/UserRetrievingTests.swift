//
//  Created by Shady
//  All rights reserved.
//  

import XCTest
import ParrotChat

protocol UserRetriever {

    typealias RetrieveUserResult = Result<[LocalUser],Error>
    typealias RetrieveUserCompletion = (RetrieveUserResult) -> Void

    func retrieveAllUsers(completion:@escaping RetrieveUserCompletion)
}

class LocalUserRetriever : UserRetriever {

    let store : UserStore

    public init(_ store:UserStore){
        self.store = store
    }

    func retrieveAllUsers(completion: @escaping RetrieveUserCompletion) {
        store.retrieveAllUsers { [weak self] result in
            guard self != nil else {return}

            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let users):
                completion(.success(users))

            }
        }        
    }
}


class UserRetrievingTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedInvocations.count, 0)
    }

    func test_retrieve_completeWithError(){
        let (sut, store) = makeSUT()
                let exp = expectation(description: "Wait for save completion")

        let retrievedError =  anyError()
        var receivedError : Error?

        sut.retrieveAllUsers(){
            if case let Result.failure(error) = $0 {
                receivedError = error
            }
        }
        exp.fulfill()

        store.completeWithRetrieveError(with: retrievedError)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError! as NSError, retrievedError)

    }

    func test_retrieve_successfully(){
        let (sut,store) = makeSUT()

        let users = [anyUser(),anyUser()]
        var receivedUsers = [LocalUser]()

        let exp = expectation(description: "Wait for save completion")
        sut.retrieveAllUsers(){
            if case let Result.success(localUsers) = $0 {
                receivedUsers = localUsers
            }
        }
        exp.fulfill()
        store.completeWithRetrieveSuccess(with: users.map{$0.local})
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(store.receivedInvocations, [.retrieve])
        XCTAssertEqual(receivedUsers, users.map{$0.local})
    }

    func test_retrieve_doesNotCompleteWithErrorAfterSutHasBeenDeallocated() {
        let store = UserStoreSpy()
        var sut: LocalUserRetriever? = LocalUserRetriever(store)

        var receivedRetrieveResults = [LocalUserRetriever.RetrieveUserResult]()
        sut?.retrieveAllUsers() {
            receivedRetrieveResults.append($0)
        }

        sut = nil
        store.completeWithRetrieveError(with: anyError())

        XCTAssertTrue(receivedRetrieveResults.isEmpty)
    }
    


    //HELPERS
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (userSaver:UserRetriever, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = LocalUserRetriever(store)
        trackForMemoryLeaks(store,file: file, line: line)
        trackForMemoryLeaks(sut,file: file, line:line)
        return (sut,store)
    }


}



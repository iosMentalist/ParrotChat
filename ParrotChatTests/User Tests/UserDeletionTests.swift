//
//  Created by Shady
//  All rights reserved.
//  

import XCTest
import ParrotChat

class UserDeletionTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedInvocations.count, 0)
    }

    func test_delete_withError(){
        let (sut,store) = makeSUT()

        let exp = expectation(description: "Wait for completion")

        let deleterror =  anyError()
        var receivedError : Error?

        sut.delete(user:anyUser().model){
            if case let Result.failure(error) = $0 {
                receivedError = error
            }
        }
        exp.fulfill()

        store.completeWithDeletionError(with: deleterror)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError! as NSError, deleterror)
    }

    func test_delete_successfully(){
        let (sut,store) = makeSUT()
        let user = anyUser()
        let exp = expectation(description: "Wait for completion")

        sut.delete(user:user.model){_ in
            exp.fulfill()
        }
        store.completeWithDeletionSuccess(user: user.local)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(store.receivedInvocations, [.delete])
    }

    func test_delete_doesNotCompleteWithErrorAfterSutHasBeenDeallocated() {
        let store = UserStoreSpy()
        var sut: LocalUserFeatures? = LocalUserFeatures(store)

        var receivedDeleteResults = [LocalUserFeatures.DeletionResult]()
        sut?.delete(user:anyUser().model) {
            receivedDeleteResults.append($0)
        }

        sut = nil
        store.completeWithDeletionError(with: anyError())

        XCTAssertTrue(receivedDeleteResults.isEmpty)
    }



    //MARK: - HELERPS
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (userDeleter:UserDeleter, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = LocalUserFeatures(store)
        trackForMemoryLeaks(store,file: file, line: line)
        trackForMemoryLeaks(sut,file: file, line:line)
        return (sut,store)
    }
}

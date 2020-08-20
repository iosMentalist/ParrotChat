//
//  Created by Shady
//  All rights reserved.
//

import XCTest
import ParrotChat

class UserSavingTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedInvocations.count, 0)
    }

    func test_save_withError(){
        let (sut,store) = makeSUT()

        let exp = expectation(description: "Wait for save completion")

        let insertError =  anyError()
        var receivedError : Error?
        
        sut.save(user:anyUser().model){
            if case let Result.failure(error) = $0 {
                receivedError = error
            }
        }
        exp.fulfill()

        store.completeWithInsertionError(with: insertError)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError! as NSError, insertError)
    }

    func test_save_successfully(){
        let (sut,store) = makeSUT()
        let user = anyUser()
        let exp = expectation(description: "Wait for save completion")

        sut.save(user:user.model){_ in
            exp.fulfill()
        }
        store.completeWithInsertionSuccess(user: user.local)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(store.receivedInvocations, [.insert(user.local)])
    }

    func test_save_doesNotCompleteWithErrorAfterSutHasBeenDeallocated() {
        let store = UserStoreSpy()
        var sut: LocalUserSaver? = LocalUserSaver(store)

        var receivedInsertResults = [LocalUserSaver.InsertionResult]()
        sut?.save(user:anyUser().model) {
            receivedInsertResults.append($0)
        }

        sut = nil
        store.completeWithInsertionError(with: anyError())

        XCTAssertTrue(receivedInsertResults.isEmpty)
    }


    //MARK: - HELERPS
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (userSaver:UserSaver, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = LocalUserSaver(store)
        trackForMemoryLeaks(store,file: file, line: line)
        trackForMemoryLeaks(sut,file: file, line:line)
        return (sut,store)
    }

    //helper function that sends back the same user for model and local boundaires
    func anyUser() -> (model:User,local:LocalUser){
        let model =  User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))

        let local =  LocalUser(name: "user name", imageName: "image", lastMessage: LocalMessage(body: "body", date: Date(), isMyMessage: true))

        return(model,local)
    }
}
extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}

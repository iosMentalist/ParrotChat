//
//  Created by Shady
//  All rights reserved.
//

import XCTest
@testable import ParrotChat

class UserSavingTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedInvocations.count, 0)
    }

    func test_save_withError(){
        let (sut,store) = makeSUT()

        let exp = expectation(description: "Wait for save completion")

        let anyError =  NSError(domain: "", code: 1, userInfo: nil)
        var receivedError : Error?
        
        sut.save(user:anyUser().model){
            if case let Result.failure(error) = $0 {
                receivedError = error
            }
        }
        exp.fulfill()

        store.completeWithInsertionError(withError: anyError)
        wait(for: [exp], timeout: 1.0)

        XCTAssertEqual(receivedError! as NSError, anyError)
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
        store.completeWithInsertionError(withError:NSError(domain: "", code: 1, userInfo: nil))

        XCTAssertTrue(receivedInsertResults.isEmpty)
    }


    //MARK: - HELERPS
    func makeSUT() -> (userSaver:UserSaver, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = LocalUserSaver(store)
        trackForMemoryLeaks(store)
        trackForMemoryLeaks(sut)
        return (sut,store)
    }

    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }


    //helper function that sends back the same user for model and local boundaires
    func anyUser() -> (model:User,local:LocalUser){
        let model =  User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))

        let local =  LocalUser(name: "user name", imageName: "image", lastMessage: LocalMessage(body: "body", date: Date(), isMyMessage: true))

        return(model,local)
    }

    //MARK: Spy
    class UserStoreSpy : UserStore{
        enum ReceivedInvocation : Equatable{
            case insert(LocalUser)
        }
        var receivedInvocations = [ReceivedInvocation]()

        private var insertionCompletions = [InsertionCompletion]()

        //MARK: User Store implemention
        func insert(user: LocalUser, completion: @escaping InsertionCompletion)  {
            insertionCompletions.append(completion)
            receivedInvocations.append(.insert(user))
        }

        //MARK: Spy's functions
        func completeWithInsertionError(withError error: Error, at index:Int = 0){
            insertionCompletions[index](.failure(error))
        }

        func completeWithInsertionSuccess(user:LocalUser, at index:Int = 0){
            insertionCompletions[index](.success(()))
        }
    }
}

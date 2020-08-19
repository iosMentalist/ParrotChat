//
//  Created by Shady
//  All rights reserved.
//

import XCTest
@testable import ParrotChat

class UserStore{

    var receivedInvocatins = 0

    func insert(user:User, completion: @escaping (Result<Void, Error>) -> Void){
        receivedInvocatins += 1
    }
}

class UserSaver {

    let store : UserStore
    init(_ store:UserStore){
        self.store = store
    }



}


class ParrotChatTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let sut = makeSUT()

        XCTAssertEqual(sut.store.receivedInvocatins, 0)
    }

    func test_streo_save_withError(){
        let (_,store) = makeSUT()

        store.insert(user:anyUser()){_ in }
        store.completeWithInsertionError()

       XCTAssertEqual(store.insertionErrors, 1)
    }



    //HELERPS
    func makeSUT() -> (userSaver:UserSaver, store:UserStoreSpy){
        let store = UserStoreSpy()
        let userSaver = UserSaver(store)

        return (userSaver,store)
    }

    func anyUser() -> User{
        return User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))
    }

    class UserStoreSpy : UserStore{

        private(set) var insertionErrors = 0

        func completeWithInsertionError(){
            insertionErrors += 1
        }

    }

}

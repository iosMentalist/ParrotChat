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

    func save(user:User,completion:@escaping(Result<Void,Error>)->Void){

    }


}


class ParrotChatTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let (_, store) = makeSUT()
        XCTAssertEqual(store.receivedInvocatins, 0)
    }

    func test_save_withError(){
        let (sut,store) = makeSUT()

       sut.save(user:anyUser()){_ in }
       store.completeWithInsertionError()

      XCTAssertEqual(store.insertionErrors, 1)
    }
    func test_save_successfully(){
        let (sut,store) = makeSUT()
        let user = anyUser()
       sut.save(user:user){_ in }
       store.completeWithInsertionSuccess()

      XCTAssertEqual(store.receivedInvocatins, 1)
    }



    //HELERPS
    func makeSUT() -> (userSaver:UserSaver, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = UserSaver(store)

        return (sut,store)
    }

    func anyUser() -> User{
        return User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))
    }

    class UserStoreSpy : UserStore{

        private(set) var insertionErrors = 0

        func completeWithInsertionError(){
            insertionErrors += 1
        }

        func completeWithInsertionSuccess(){
           receivedInvocatins += 1
       }

    }

}

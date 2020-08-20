//
//  Created by Shady
//  All rights reserved.
//

import XCTest
@testable import ParrotChat


struct LocalUser {
    var name : String
    var imageName : String
    var lastMessage : LocalMessage
}
struct LocalMessage {
    var body : String
    var date : Date
    var isMyMessage : Bool
}
class UserStore{

    func insert(user:User, completion: @escaping (Result<Void, Error>) -> Void){

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
        XCTAssertEqual(store.receivedInvocations.count, 0)
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
        store.completeWithInsertionSuccess(user: user)

        XCTAssertEqual(store.receivedInvocations, [.insert])
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
        enum ReceivedInvocation {
            case insert(User)
        }
        var receivedInvocations = [ReceivedInvocation]()

        private(set) var insertionErrors = 0

        func completeWithInsertionError(){
            insertionErrors += 1
        }

        func completeWithInsertionSuccess(user:User){
            insert(user: user){_ in}
            receivedInvocations.append(.insert(user))
        }

    }

}

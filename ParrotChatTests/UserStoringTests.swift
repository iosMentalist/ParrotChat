//
//  Created by Shady
//  All rights reserved.
//

import XCTest
@testable import ParrotChat


struct LocalUser : Equatable{
    static func == (lhs: LocalUser, rhs: LocalUser) -> Bool {
        return lhs.name == rhs.name
    }
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

    func insert(user:LocalUser, completion: @escaping (Result<Void, Error>) -> Void){

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

        sut.save(user:anyUser().model){_ in }
        store.completeWithInsertionError()

        XCTAssertEqual(store.insertionErrors, 1)
    }
    func test_save_successfully(){
        let (sut,store) = makeSUT()
        let user = anyUser()

        sut.save(user:user.model){_ in }
        store.completeWithInsertionSuccess(user: user.local)

        XCTAssertEqual(store.receivedInvocations, [.insert(user.local)])
    }



    //HELERPS
    func makeSUT() -> (userSaver:UserSaver, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = UserSaver(store)

        return (sut,store)
    }

    func anyUser() -> (model:User,local:LocalUser){
        let model =  User(name: "user name", imageName: "image", lastMessage: Message(body: "body", date: Date(), isMyMessage: true))

        let local =  LocalUser(name: "user name", imageName: "image", lastMessage: LocalMessage(body: "body", date: Date(), isMyMessage: true))
        return(model,local)
    }

    class UserStoreSpy : UserStore{
        enum ReceivedInvocation : Equatable{
            case insert(LocalUser)
        }
        var receivedInvocations = [ReceivedInvocation]()

        private(set) var insertionErrors = 0

        func completeWithInsertionError(){
            insertionErrors += 1
        }

        func completeWithInsertionSuccess(user:LocalUser){
            insert(user: user){_ in}
            receivedInvocations.append(.insert(user))
        }

    }

}

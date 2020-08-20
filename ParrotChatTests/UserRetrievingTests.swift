//
//  Created by Shady
//  All rights reserved.
//  

import XCTest
import ParrotChat

class UserRetriever{
    let store : UserStore

       public init(_ store:UserStore){
           self.store = store
       }
}

class UserRetrievingTests: XCTestCase {

    func test_init_doesntInvokeStoreWhenCreated(){

        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedInvocations.count, 0)
    }


    //HELPERS
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (userSaver:UserRetriever, store:UserStoreSpy){
        let store = UserStoreSpy()
        let sut = UserRetriever(store)
        trackForMemoryLeaks(store,file: file, line: line)
        trackForMemoryLeaks(sut,file: file, line:line)
        return (sut,store)
    }


}



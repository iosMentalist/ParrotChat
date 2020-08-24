//
//  Created by Shady
//  All rights reserved.
//
import Foundation

let MESSAGE_ADDED = "MESSAGE_ADDED"

final class NotificationCenterHelper: NSObject {
    private static let shared = NotificationCenter.default

    #warning("user is not used, may be removed")
    static func postMessageAdded(user:User){
        shared.post(name: NSNotification.Name(MESSAGE_ADDED), object: nil,userInfo: ["user":user])
    }
    static func listenMessageAdded(observer: Any,selector: Selector) {
        shared.addObserver(observer, selector: selector, name: NSNotification.Name(MESSAGE_ADDED), object: nil)

    }
}

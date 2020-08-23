//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet var tableUsersController: TableUserController!
    var model : [User]? {
        willSet{
            tableUsersController.model = newValue!
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @objc func refreshView(notification:NSNotification){
        refreshTable()
    }

    func refreshTable(){
//        setupData()
//        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChatDetail" {
            let vc = segue.destination as! ChatDetailViewController
            vc.currentChat = (sender as! Chat)
        }
    }
}


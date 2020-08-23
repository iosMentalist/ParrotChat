//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet var tableUsersController: TableUserController!
    var userFeautres : LocalUserFeatures?
    var model : [User]? {
        willSet{
            tableUsersController.setup(parentViewController: self,model:newValue!,userFeautres: userFeautres!)
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
}


//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet var tableUsersController: TableUserController!

    var userFeature : LocalUserFeatures?{
        didSet{
            setupData()
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
//        setupInterface()
//        NotificationCenterHelper.listenMessageAdded(observer: self, selector: #selector(refreshView))
    }

    func setupData(){
        userFeature?.retrieveAllUsers(completion: { [weak self] (result) in
            guard let self = self else {return}
            switch result {
            case.success(let users) :
                self.tableUsersController.model = users.map{$0.model}
            case.failure(let error):
                debugPrint("error in retriveing user from db \(error)")
            }
        })
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


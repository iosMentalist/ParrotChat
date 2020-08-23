//
//  Created by Shady
//  All rights reserved.
//  

import UIKit
class TableUserController :NSObject, UITableViewDelegate, UITableViewDataSource{

    var model = [User]()
    var parentViewController : UIViewController!
    var userFeautres : LocalUserFeatures?

    @IBOutlet var tableView : UITableView!{
        didSet{
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 90
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    func setup(parentViewController:UIViewController, model:[User],userFeautres : LocalUserFeatures){
        self.model = model
        self.parentViewController = parentViewController
        self.userFeautres = userFeautres
    }

    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = model[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.lblUserName?.text = item.name
        if let lastmsg = item.chat?.messages.last{
            cell.lblLastMsg?.text = "\(lastmsg.body)\n\(lastmsg.date.toString())"
            cell.lblLastMsg.textColor = .lightGray
            cell.lblLastMsg.font = UIFont.systemFont(ofSize: 12)
        }
        else{
            cell.lblLastMsg.isHidden = true
        }
        cell.imgProfile?.image = UIImage(named: item.imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = model[indexPath.row]
        user.chat = (user.chat == nil) ? Chat(messages: [], date: Date()) : user.chat
        goToChatDetail(user:user)
    }

    //MARK: helpers
    private func goToChatDetail(user:User){
        let vc = ChatViewComposer.create(userFeatures: userFeautres!, user:user)
        self.parentViewController.navigationController!.pushViewController(vc, animated: true)
    }
}

extension Date{
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        let string = dateFormatter.string(from: self)
        return string
    }

}

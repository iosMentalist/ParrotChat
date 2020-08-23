//
//  Created by Shady
//  All rights reserved.
//  

import UIKit
class TableUserController :NSObject, UITableViewDelegate, UITableViewDataSource{

    var model = [User]()
    var parentViewController : UIViewController!

    @IBOutlet var tableView : UITableView!{
        didSet{
            tableView.rowHeight = 80
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    func setup(parentViewController:UIViewController,model:[User]){
        self.model = model
        self.parentViewController = parentViewController
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
        cell.lblLastMsg?.text = item.chat?.messages.last?.date.toString()
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
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ChatDetailViewController") as! ChatDetailViewController
        vc.user = user
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

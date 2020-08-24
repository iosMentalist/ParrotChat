//
//  Created by Shady
//  All rights reserved.
//  

import UIKit
class TableUserController :NSObject, UITableViewDelegate, UITableViewDataSource{

    var model = [User]()
    var viewModel = [User]()
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
        self.parentViewController = parentViewController
        self.userFeautres = userFeautres
        updateModel(model: model)
        NotificationCenterHelper.listenMessageAdded(observer: self, selector: #selector(userUpdated))
    }

    private func updateModel(model:[User]){
        self.model = model
        self.setupViewModelArray()
    }

    @objc private func userUpdated(){
        userFeautres?.retrieveAllUsers(){ result in
            switch result {
            case.success(let localUsers) :
                self.updateModel(model: localUsers.map{$0.model})
                DispatchQueue.main.async{ self.tableView.reloadData()}
            case.failure(let error):
                debugPrint("error in retriveing user from db \(error)")
            }
        }

    }
    private func setupViewModelArray(){
        viewModel.removeAll()
        var usersWithChats = model.filter{$0.chat != nil &&  $0.chat!.messages.count > 0}
        usersWithChats.sort(by: { $0.chat!.messages.last!.date.compare($1.chat!.messages.last!.date) == .orderedDescending})
        let usersWithNoChats = model.filter{$0.chat == nil ||  $0.chat!.messages.count == 0}
        viewModel.append(contentsOf: usersWithChats)
        viewModel.append(contentsOf: usersWithNoChats)
    }

    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        configureCell(cell: cell, user: item)
        return cell
    }

    private func configureCell(cell:UserTableViewCell,user item:User){
        cell.lblUserName?.text = item.name
        if let lastmsg = item.chat?.messages.last{
            cell.lblLastMsg.isHidden = false
            cell.lblDate.isHidden = false
            cell.lblLastMsg?.text = "\(lastmsg.body)"
            cell.lblDate.text = "\(lastmsg.date.toString())"
        }
        else{
            cell.lblLastMsg.isHidden = true
            cell.lblDate.isHidden = true
        }
        cell.imgProfile?.image = UIImage(named: item.imageName)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var user = viewModel[indexPath.row]
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
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale
        let string = dateFormatter.string(from: self)
        return string
    }

}

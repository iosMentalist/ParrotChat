//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class ChatDetailViewController: UIViewController {

    private let VIEW_CHAT_BOTTOM_CONSTANT : CGFloat = 0
    @IBOutlet weak var vwChat: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var constBtm: NSLayoutConstraint!

    var messagesArray : [Message]?
    var user : User? {
        willSet{
            messagesArray = newValue?.chat!.messages
        }
    }
    var userFeatures : LocalUserFeatures?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        //        NotificationCenterHelper.listenMessageAdded(observer: self, selector: #selector(refreshView))
    }

    private func setupInterface(){
        self.navigationItem.title = user!.name
        txtField.delegate = self
        txtField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        btnSend.isEnabled = false
        btnSend.setTitleColor(.white, for: .normal)
        btnSend.setTitleColor(.gray, for: .disabled)
        constBtm.constant = VIEW_CHAT_BOTTOM_CONSTANT
        self.view.layoutIfNeeded()
        registerForKeyboardNotifications()
    }

    @IBAction func sendAction(_ sender: Any) {
        if let msg = txtField.text, !txtField.text!.isEmpty{
            user?.chat?.messages.append(Message(body: msg, date: Date(), isMyMessage: true))
            self.tableView.reloadData()
            self.resetChatView()
            parrotAnswer(msg)
        }
    }

    private func parrotAnswer(_ msg:String){
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self]_ in
            guard let self = self else {return}
            self.user?.chat?.messages.append(Message(body: "\(msg) \(msg)", date: Date(), isMyMessage: false))
            self.tableView.reloadData()
            self.userFeatures?.update(user: self.user!, completion: { _ in })
        }
    }

    private func resetChatView(){
        DispatchQueue.main.async{
            self.txtField.resignFirstResponder()
            self.txtField.text = ""
            self.btnSend.isEnabled = false
            self.scrollToUsertom()
        }
    }
    
    func scrollToUsertom(){
        self.tableView.scrollToRow(at: IndexPath(row: (self.user?.chat!.messages.count)!-1, section: 0), at: UITableView.ScrollPosition.bottom, animated: true)
    }

    //    @objc func refreshView(notification:NSNotification){
    //        if let chat = notification.userInfo?["chat"] as? Chat {
    //            self.currentChat = chat
    //            tableView.reloadData()
    //        }
    //    }

    //MARK: Handle Keyboard
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }

}
//MARK: - table view delegates
extension ChatDetailViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : BaseTableViewCell
        let item = messagesArray![indexPath.row]
        if item.isMyMessage{
            cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell", for: indexPath) as! SenderTableViewCell
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell

        }
        configureCell(cell: cell, forRowAt: indexPath)
        return cell
    }

    func configureCell(cell: BaseTableViewCell, forRowAt indexPath: IndexPath) {
        let item = messagesArray![indexPath.row]
        cell.lblText.text = !item.isMyMessage ? "user : \(item.body)" : "\(item.body) : me"
    }
}


//MARK: - keyboard hanlding
extension ChatDetailViewController {

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardAppear(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func onKeyboardAppear(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            constBtm.constant = keyboardSize.height
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func onKeyboardDisappear(_ notification: NSNotification) {
        constBtm.constant = VIEW_CHAT_BOTTOM_CONSTANT
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
}

//MARK: - UITextField Delegate Methods
extension ChatDetailViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtField.resignFirstResponder()
        return true
    }

    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        btnSend.isEnabled = !sender.text!.isEmpty
    }
}



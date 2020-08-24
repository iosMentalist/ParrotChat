//
//  Created by Shady
//  All rights reserved.
// 

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblLastMsg: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        imgProfile.clipsToBounds = true

        lblLastMsg.textColor = .lightGray
        lblLastMsg.font = UIFont.systemFont(ofSize: 12)
        lblDate.textColor = .lightGray
        lblDate.font = UIFont.systemFont(ofSize: 12)
    }

}

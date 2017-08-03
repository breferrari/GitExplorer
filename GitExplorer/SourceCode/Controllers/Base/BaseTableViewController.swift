import UIKit
import SVProgressHUD

class BaseTableViewController: UITableViewController {

    //MARK: Loading HUD
    
    internal func showLoadingHUD() {
        SVProgressHUD.show()
    }
    
    internal func showLoadingHUDWithInfo(_ info: String) {
        SVProgressHUD.showInfo(withStatus: info)
    }
    
    internal func dismissLoadingHUD() {
        SVProgressHUD.dismiss()
    }
    
    //MARK: Custom View Title
    
    internal func setGitExplorerTitle() {
        if #available(iOS 8.2, *) {
            let regularAttributes = [
                NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular),
                NSForegroundColorAttributeName : UIColor.white ]
            
            let boldAttributes = [
                NSFontAttributeName : UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold),
                NSForegroundColorAttributeName : UIColor.white ]
            
            let formattedString = NSMutableAttributedString(string: "GitExplorer", attributes: boldAttributes)
            formattedString.addAttributes(regularAttributes, range: NSRange(location: 0, length: 3))
            
            let navLabel = UILabel()
            navLabel.attributedText = formattedString
            navLabel.sizeToFit()
            self.navigationItem.titleView = navLabel
        }
    }
    
}

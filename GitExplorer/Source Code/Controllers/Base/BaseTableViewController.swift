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
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular),
                NSAttributedStringKey.foregroundColor : UIColor.white ]
            
            let boldAttributes = [
                NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.bold),
                NSAttributedStringKey.foregroundColor : UIColor.white ]
            
            let formattedString = NSMutableAttributedString(string: "GitExplorer", attributes: boldAttributes)
            formattedString.addAttributes(regularAttributes, range: NSRange(location: 0, length: 3))
            
            let navLabel = UILabel()
            navLabel.attributedText = formattedString
            navLabel.sizeToFit()
            self.navigationItem.titleView = navLabel
        }
    }
    
}

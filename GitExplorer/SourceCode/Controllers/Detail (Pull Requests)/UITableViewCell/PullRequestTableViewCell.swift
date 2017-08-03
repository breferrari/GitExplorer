import UIKit
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var pullRequestTitleLabel: UILabel!
    @IBOutlet private weak var pullRequestDescription: UILabel!

    @IBOutlet private weak var authorImageView: UIImageView!
    @IBOutlet private weak var authorNameLabel: UILabel!
    
    var pullRequest: PullRequest? {
        didSet {
            pullRequestTitleLabel.text = pullRequest?.title
            pullRequestDescription.text = pullRequest?.body
            if let author = pullRequest?.author {
                authorImageView.sd_setImage(with: author.avatarUrl)
                authorNameLabel.text = author.login
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        authorImageView.layer.cornerRadius = authorImageView.frame.size.width / 2
        authorImageView.sd_setShowActivityIndicatorView(true)
        authorImageView.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
    }
    
    override func prepareForReuse() {
        pullRequestTitleLabel.text = ""
        pullRequestDescription.text = ""
        authorImageView.image = UIImage(named: Config.Assets.Icons.userPlaceholder)
        authorNameLabel.text = ""
    }
    
    class func cellHeight() -> CGFloat {
        return 153.5
    }
    
}

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var containerView: UIView!
    
    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    
    @IBOutlet private weak var repositoryForkCountLabel: UILabel!
    @IBOutlet private weak var repositoryStarCountLabel: UILabel!
    
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    
    var repository: Repository? {
        didSet {
            repositoryNameLabel.text = repository?.name
            repositoryDescriptionLabel.text = repository?.description
            repositoryForkCountLabel.text = "\(repository?.forkCount ?? 0)"
            repositoryStarCountLabel.text = "\(repository?.stargazersCount ?? 0)"
            userImageView.sd_setImage(with: repository?.owner.avatarUrl)
            ownerNameLabel.text = repository?.owner.login
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.sd_setShowActivityIndicatorView(true)
        userImageView.sd_setIndicatorStyle(UIActivityIndicatorViewStyle.gray)
    }
    
    override func prepareForReuse() {
        repositoryNameLabel.text = ""
        repositoryDescriptionLabel.text = ""
        repositoryForkCountLabel.text = "0"
        repositoryStarCountLabel.text = "0"
        userImageView.image = UIImage(named: Config.Assets.Icons.userPlaceholder)
        ownerNameLabel.text = ""
    }
    
    class func cellHeight() -> CGFloat {
        return 136.5
    }
    
}

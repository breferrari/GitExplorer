import UIKit

class DetailTableViewController: BaseTableViewController {
    
    var repository: Repository? {
        didSet {
            if let repository = repository {
                title = repository.name
                loadData(repository)
            }
        }
    }
    
    private var dataSource: PullRequestContainer?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(withClass: PullRequestTableViewCell.self)
        
        tableView.estimatedRowHeight = PullRequestTableViewCell.cellHeight()
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    private func loadData(_ repository: Repository) {
        if let dataSource = self.dataSource, dataSource.totalCount == dataSource.pullRequests.count {
            return
        }
        
        showLoadingHUD()
        GitHubService.queryPullRequests(owner: repository.owner.login, name: repository.name, cursor: dataSource?.lastCursor) { [weak self] (container) in
            if let container = container {
                if self?.dataSource?.lastCursor != nil {
                    self?.dataSource?.append(container)
                } else {
                    self?.dataSource = container
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            
            self?.dismissLoadingHUD()
        }
    }
    
    // MARK: - UITableView Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.pullRequests.count
        } else {
            return 0
        }
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PullRequestTableViewCell.cellHeight()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            if dataSource.pullRequests.count - 1 == indexPath.row, let repository = repository {
                loadData(repository)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(forClass: PullRequestTableViewCell.self)
        cell.pullRequest = dataSource?.pullRequests[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            let pullRequest = dataSource.pullRequests[indexPath.row]
            UIApplication.shared.openURL(pullRequest.url)
        }
    }
    
}

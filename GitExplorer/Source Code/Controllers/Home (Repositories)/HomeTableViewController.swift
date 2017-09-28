import UIKit

class HomeTableViewController: BaseTableViewController {
    
    fileprivate var dataSource: RepositoryContainer?
    
    fileprivate var language: String = "Swift"

    override func viewDidLoad() {
        super.viewDidLoad()
        setGitExplorerTitle()
        configureNavigationBar()
        configureTableView()
        
        loadData()
    }
    
    private func configureNavigationBar() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filterAction))
        self.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func configureTableView() {
        tableView.registerNib(withClass: RepositoryTableViewCell.self)
        
        tableView.estimatedRowHeight = RepositoryTableViewCell.cellHeight()
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func loadData() {
        if let dataSource = self.dataSource, dataSource.repositoryCount == dataSource.repositories.count {
            return
        }
        
        showLoadingHUD()
        GitHubService.queryRepositories(language: language, cursor: dataSource?.lastCursor, completion: { [weak self] (container) in
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
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailTableViewController, let repository = sender as? Repository {
            destination.repository = repository
        }
    }

    // MARK: - UITableView Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.repositories.count
        } else {
            return 0
        }
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryTableViewCell.cellHeight()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            if dataSource.repositories.count - 1 == indexPath.row {
                loadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(forClass: RepositoryTableViewCell.self)
        cell.repository = dataSource?.repositories[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = dataSource {
            Config.Segues.repositoryDetail.performSegue(in: self, with: dataSource.repositories[indexPath.row])
        }
    }

}

// MARK: - Language Search

extension HomeTableViewController {
    
    @objc fileprivate func filterAction() {
        let alert = UIAlertController.init(title: "Language Filter", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.view.tintColor = UIColor.black
        
        alert.addTextField { (textField) in
            textField.placeholder = "Type the programming language"
        }
        
        let alertActionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertActionCancel)
        
        let alertActionSearch = UIAlertAction.init(title: "Search", style: UIAlertActionStyle.default) { (alertAction) in
            if let textFields = alert.textFields, let textField = textFields.last, let text = textField.text {
                self.changeLanguageTo(text)
            }
        }
        alert.addAction(alertActionSearch)
        
        present(alert, animated: true) { 
            if let textFields = alert.textFields, let textField = textFields.last {
                textField.becomeFirstResponder()
            }
        }
    }
    
    fileprivate func changeLanguageTo(_ language: String) {
        if (self.language != language) {
            self.language = language
            self.dataSource = nil
            
            loadData()
        }
    }
    
}

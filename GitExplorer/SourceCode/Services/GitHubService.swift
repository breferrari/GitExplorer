import UIKit
import Moya
import Unbox

class GitHubService {
    
    typealias CompletionRepository = (_ container: RepositoryContainer?) -> Swift.Void
    typealias CompletionPullRequest = (_ container: PullRequestContainer?) -> Swift.Void
    
    class func queryRepositories(language: String, cursor: String?, completion: @escaping CompletionRepository) {
        
        let gitHub = MoyaProvider<GitHub>(endpointClosure: GitHubClosure)
        
        gitHub.request(.repositories(language: language, cursor: cursor)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        
                        let container: RepositoryContainer = try unbox(dictionary: json)
                        completion(container)
                        
                    }
                } catch let error as NSError {
                    print("[GithubService] Error Parsing JSON: \(error)")
                    completion(nil)
                }
                
            case let .failure(error):
                handle(error)
                completion(nil)
            }
        }
    }
    
    class func queryPullRequests(owner: String, name: String, cursor: String?, completion: @escaping CompletionPullRequest) {
        
        let gitHub = MoyaProvider<GitHub>(endpointClosure: GitHubClosure)
        
        gitHub.request(.pullRequests(owner: owner, name: name, cursor: cursor)) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] {
                        
                        let container: PullRequestContainer = try unbox(dictionary: json)
                        completion(container)
                        
                    }
                } catch let error as NSError {
                    print("[GithubService] Error Parsing JSON: \(error)")
                    completion(nil)
                }
                
            case let .failure(error):
                handle(error)
                completion(nil)
            }
        }
    }
    
    private class func handle(_ error: MoyaError) {
        print("[GitHubService] Error: \(error)")
    }
}

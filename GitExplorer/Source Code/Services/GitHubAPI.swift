import UIKit
import Moya

fileprivate struct GitHubAPI {
    
    struct Config {
        static var endPoint: String {
            return "https://api.github.com/graphql"
        }
        static var accessToken: String {
            return "c5ac86196495143012e8d12748e422779b7ec95c"
        }
    }
    
    struct Query {
        struct Size {
            enum Limit: Int {
                case Ten = 10
                case Twenty =  20
                case Thirty = 30
                case Fourty =  40
            }
            
            static var defaultLimit: Int {
                return Limit.Thirty.rawValue
            }
        }
        
        static func repositories(language: String, cursor: String?) -> [String: Any] {
            if let cursor = cursor {
                
                let variables: [String: Any] = [ "language"  : "language:\(language)",
                                                 "querySize" : Query.Size.defaultLimit,
                                                 "cursor"    : cursor ]
                return ["query": GraphQL.Repository.query(cursor: true), "variables" : variables]
                
            } else {
                
                let variables: [String: Any] = [ "language"  : "language:\(language)",
                                                 "querySize" : Query.Size.defaultLimit ]
                return ["query": GraphQL.Repository.query(cursor: false), "variables" : variables]
                
            }
        }
        static func pullRequests(owner: String, name: String, cursor: String?) -> [String: Any] {
            if let cursor = cursor {
                
                let variables: [String: Any] = [ "owner"     : owner,
                                                 "name"      : name,
                                                 "querySize" : Query.Size.defaultLimit,
                                                 "cursor"    : cursor ]
                return ["query": GraphQL.PullRequest.query(cursor: true), "variables" : variables]
                
            } else {
                
                let variables: [String: Any] = [ "owner"     : owner,
                                                 "name"      : name,
                                                 "querySize" : Query.Size.defaultLimit ]
                return ["query": GraphQL.PullRequest.query(cursor: false), "variables" : variables]
                
            }
        }
    }
    
}

enum GitHub {
    case repositories(language: String, cursor: String?)
    case pullRequests(owner: String, name: String, cursor: String?)
}

extension GitHub: TargetType {
    var headers: [String : String]? {
        return ["Authorization": "bearer \(GitHubAPI.Config.accessToken)"];
    }
    
    var baseURL: URL {
        return URL(string: GitHubAPI.Config.endPoint)!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .repositories(let language, let cursor):
            return GitHubAPI.Query.repositories(language: language, cursor: cursor)
        case .pullRequests(let owner, let name, let cursor):
            return GitHubAPI.Query.pullRequests(owner: owner, name: name, cursor: cursor)
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        switch self {
        case .repositories:
            guard let url = Bundle.main.url(forResource: "repositories-stub", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
            
        case.pullRequests:
            guard let url = Bundle.main.url(forResource: "pullRequests-stub", withExtension: "json"),
                let data = try? Data(contentsOf: url) else {
                    return Data()
            }
            return data
        }
    }
    
    var task: Task {
        guard let parameters = parameters else {
            return .requestPlain
        }
        
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
}

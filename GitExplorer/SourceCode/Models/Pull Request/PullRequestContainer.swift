import UIKit
import Unbox

struct PullRequestContainer {
    
    var totalCount: Int
    var lastCursor: String?
    var pullRequests: Array<PullRequest>
    
}


extension PullRequestContainer: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        totalCount   = try unboxer.unbox(keyPath: "data.repository.pullRequests.totalCount")
        pullRequests = try unboxer.unbox(keyPath: "data.repository.pullRequests.edges")
        
        if let pullRequest = pullRequests.last {
            lastCursor = pullRequest.cursor
        } else {
            lastCursor = nil
        }
        
    }
    
    mutating func append(_ newQuery: PullRequestContainer) {
        
        totalCount = newQuery.totalCount
        lastCursor = newQuery.lastCursor
        pullRequests.append(contentsOf: newQuery.pullRequests)
        
    }
    
}

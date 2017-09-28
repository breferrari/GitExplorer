import UIKit
import Unbox

struct Repository {
    
    let cursor: String
    
    let id: String
    let name: String
    let nameWithOwner: String
    let description: String?
    let stargazersCount: Int
    let forkCount: Int
    let owner: User
    
}


extension Repository: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        cursor          = try unboxer.unbox(key: "cursor")
        id              = try unboxer.unbox(keyPath: "node.id")
        name            = try unboxer.unbox(keyPath: "node.name")
        nameWithOwner   = try unboxer.unbox(keyPath: "node.nameWithOwner")
        description     = unboxer.unbox(keyPath: "node.description")
        stargazersCount = try unboxer.unbox(keyPath: "node.stargazers.totalCount")
        forkCount       = try unboxer.unbox(keyPath: "node.forks.totalCount")
        owner           = try unboxer.unbox(keyPath: "node.owner")
        
    }
    
}

import UIKit
import Unbox

struct PullRequest {
    
    let cursor: String
    
    let title: String
    var body: String
    let url: URL
    var author: User?
    
}


extension PullRequest: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        cursor = try unboxer.unbox(key: "cursor")
        title  = try unboxer.unbox(keyPath: "node.title")
        body   = try unboxer.unbox(keyPath: "node.body")
        
        if body == "" {
            body = "<No Description>"
        }
        
        url    = try unboxer.unbox(keyPath: "node.url")
        author = unboxer.unbox(keyPath: "node.author")
        
        if author == nil {
            author = User()
        }

    }
    
}

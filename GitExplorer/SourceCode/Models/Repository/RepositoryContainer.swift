import UIKit
import Unbox

struct RepositoryContainer {
    
    var repositoryCount: Int
    var lastCursor: String?
    var repositories: Array<Repository>
    
}


extension RepositoryContainer: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        repositoryCount = try unboxer.unbox(keyPath: "data.search.repositoryCount")
        repositories    = try unboxer.unbox(keyPath: "data.search.edges")
        
        if let repository = repositories.last {
            lastCursor = repository.cursor
        } else {
            lastCursor = nil
        }
        
    }
    
    mutating func append(_ newQuery: RepositoryContainer) {
        
        repositoryCount = newQuery.repositoryCount
        lastCursor      = newQuery.lastCursor
        repositories.append(contentsOf: newQuery.repositories)
        
    }
    
}

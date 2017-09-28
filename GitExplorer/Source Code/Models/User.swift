import UIKit
import Unbox

struct User {
    
    let login: String
    let avatarUrl: URL
    
}

extension User: Unboxable {
    
    init(unboxer: Unboxer) throws {
        
        login     = try unboxer.unbox(key: "login")
        avatarUrl = try unboxer.unbox(key: "avatarUrl")
        
    }
    
    init() {
        login = "ghost"
        avatarUrl = URL(string: "https://avatars1.githubusercontent.com/u/10137?v=4&s=88")!
    }
    
}

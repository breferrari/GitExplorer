import UIKit

struct Config {
    
    struct Nib {
        static func loadNib(name: String?) -> UINib? {
            guard let name = name else {
                return nil
            }
            
            let bundle = Bundle.main
            let nib = UINib(nibName: name, bundle: bundle)
            
            return nib
        }
    }
    
    struct Assets {
        struct Icons {
            static var star: String {
                return "icon-star"
            }
            static var fork: String {
                return "icon-fork"
            }
            static var userPlaceholder: String {
                return "icon-user-placeholder"
            }
        }
    }
    
    enum Segues: String, SegueRepresentable {
        case repositoryDetail = "DetailSegue"
    }
    
}

import UIKit

// MARK: - Reusable Protocol
protocol ReusableCellIdentifiable {
    static var cellIdentifier: String { get }
}

extension ReusableCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableCellIdentifiable {}

// MARK: - Enum Representable Protocols
protocol SegueRepresentable: RawRepresentable {
    func performSegue(in viewController: UIViewController)
    func performSegue(in viewController: UIViewController, with object: Any?)
}

import UIKit

final class DetailsRegionViewController: UIViewController {
    override func loadView() {
        let customView = DetailsRegionView()
        customView.configure()
        view = customView
    }
}

import UIKit

final class SelectedImageViewController: UIViewController {
    private let customView = SelectedImageView()
    var imageName: String?
    
    override func loadView() {
        super.loadView()
        view = customView
    }
    
    override func viewDidLoad() {
        customView.configure(imageName ?? "")
    }
}

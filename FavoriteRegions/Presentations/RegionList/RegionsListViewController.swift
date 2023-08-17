import UIKit

class RegionsListViewController: UIViewController {

    override func loadView() {
        let customView = RegionsListView()
        customView.configure()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        title = "Любимые регионы"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

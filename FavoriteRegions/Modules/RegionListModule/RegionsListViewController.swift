import UIKit

protocol RegionsListViewControllerDelegate: AnyObject {
    func showDetailsViewController()
}

class RegionsListViewController: UIViewController {
    
    weak var delegate: RegionsListViewDelegate?

    override func loadView() {
        let customView = RegionsListView()
        customView.delegate = self
        delegate = customView
        customView.configure()
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.updateCollectionView()
    }
    
    private func setupNavigationBar() {
        title = "Любимые регионы"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension RegionsListViewController: RegionsListViewControllerDelegate {
    func showDetailsViewController() {
        let detailsVC = DetailsRegionViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

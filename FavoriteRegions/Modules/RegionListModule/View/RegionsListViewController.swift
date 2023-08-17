import UIKit

protocol RegionsListViewControllerDelegate: AnyObject {
    func navigateDetailsViewController()
}

protocol RegionsListViewControllerProtocol: AnyObject {
    func showDetailsViewController()
}

class RegionsListViewController: UIViewController, RegionsListViewControllerProtocol {
    
    var presenter: RegionsListPresenterProtocol?
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

extension RegionsListViewController {
    func showDetailsViewController() {
        let detailsVC = DetailsRegionViewController()
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

extension RegionsListViewController: RegionsListViewControllerDelegate {
    func navigateDetailsViewController() {
        presenter?.didSelectItem()
    }
}

import UIKit

protocol RegionsListViewControllerDelegate: AnyObject {
    func navigateDetailsViewController()
}

protocol RegionsListViewControllerProtocol: AnyObject {
    func showDetailsViewController()
}

class RegionsListViewController: UIViewController, RegionsListViewControllerProtocol {
    
    private var regions = [Region]()
    
    var presenter: RegionsListPresenterProtocol?
    weak var delegate: RegionsListViewDelegate?
    
    override func loadView() {
        let customView = RegionsListView()
        customView.delegate = self
        delegate = customView
        customView.configure(regions)
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.updateCollectionView()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        presenter?.fetchRegions()
        regions = presenter?.regionsList ?? []
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
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

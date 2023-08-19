import UIKit

protocol RegionsListViewControllerDelegate: AnyObject {
    func navigateDetailsViewController(_ region: Region)
}

protocol RegionsListViewControllerProtocol: AnyObject {
    func showDetailsViewController(_ region: Region)
    func updateRegions(_ regions: [Region])
    func startLoading()
    func stopLoading()
}

class RegionsListViewController: UIViewController {
    
    private let customView = RegionsListView()

    private var regions = [Region]() {
        didSet {
            delegate?.reloadCollectionView()
        }
    }
    
    var presenter: RegionsListPresenterProtocol?
    weak var delegate: RegionsListViewDelegate?
    
    override func loadView() {
        customView.delegate = self
        delegate = customView
        customView.configure()
        view = customView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.updateCollectionView()
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

extension RegionsListViewController: RegionsListViewControllerProtocol {
    func showDetailsViewController(_ region: Region) {
        let detailsVC = DetailsRegionViewController()
        detailsVC.region = region
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func updateRegions(_ regions: [Region]) {
        self.regions = regions
        customView.regions = regions
    }
    
    func startLoading() {
        delegate?.startActivityIndicator()
    }
    
    func stopLoading() {
        delegate?.stopActivityIndicator()
    }
}

extension RegionsListViewController: RegionsListViewControllerDelegate {
    func navigateDetailsViewController(_ region: Region) {
        presenter?.didSelectItem(region)
    }
}

import UIKit

protocol RegionsListViewControllerDelegate: AnyObject {
    func navigateDetailsViewController(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool)
    func reloadFetchRegions()
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func isLike(_ index: Int) -> Bool
    func toggleLikeState(_ indexPath: IndexPath, _ isLiked: Bool)
    func updateCollectionView(_ selectedIndexPath: IndexPath)
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
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
    }
    
    private func setupNavigationBar() {
        title = "Любимые регионы"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchData() {
        presenter?.fetchRegions { [weak self] regions in
            guard let self = self else { return }
            if regions.isEmpty {
                self.showAlert(
                    title: "Не получилось загрузить данные",
                    message: "Попробуйте еще раз"
                ) { _ in
                    self.fetchData()
                }
            } else {
                self.regions = regions
            }
        }
    }
}

extension RegionsListViewController: RegionsListViewControllerProtocol {
    func showDetailsViewController(_ region: Region, _  currentIndexPath: IndexPath?, _ isLike: Bool) {
        let detailsVC = DetailsRegionViewController()
        detailsVC.delegate = self
        detailsVC.region = region
        detailsVC.indexPath = currentIndexPath
        detailsVC.isLike = isLike
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
    
    func stopRefreshing() {
        delegate?.stopRefreshControl()
    }
    
    func showErrorAlert() {
        showAlert(
            title: "Oшибка",
            message: "Проверьте ваше интернет соединение"
        ) { [weak self] _ in
            self?.fetchData()
        }
    }
}

extension RegionsListViewController: RegionsListViewControllerDelegate {
    func navigateDetailsViewController(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool) {
        presenter?.didSelectItem(region, currentIndexPath, isLike)
    }
    
    func reloadFetchRegions() {
        fetchData()
    }
    
    func addLike(_ index: Int) {
        presenter?.addLike(index)
    }
    
    func deleteLike(_ index: Int) {
        presenter?.deleteLike(index)
    }
    
    func isLike(_ index: Int) -> Bool {
        guard let result = presenter?.setLike(index) else { return false }
        return result
    }
    
    func toggleLikeState(_ indexPath: IndexPath, _ isLiked: Bool) {
        if !isLiked {
            deleteLike(indexPath.row)
        } else {
            addLike(indexPath.row)
        }
        delegate?.reloadCollectionViewCell(indexPath)
    }
    
    func updateCollectionView(_ selectedIndexPath: IndexPath) {
        delegate?.updateCollectionView(selectedIndexPath)
    }
}

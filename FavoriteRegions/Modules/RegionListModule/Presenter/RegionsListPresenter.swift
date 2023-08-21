import Foundation

protocol RegionsListPresenterProtocol {
    var regionsList: [Region] { get }
    func didSelectItem(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool)
    func fetchRegions()
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func setLike(_ index: Int) -> Bool
}

final class RegionsListPresenter {
    private let regionLoader: RegionsLoaderProtocol
    private let likesManager: LikesManagerProtocol
    private var regions = [Region]()
    
    weak var view: RegionsListViewControllerProtocol?
    
    init(
        regionLoader: RegionsLoaderProtocol = RegionsLoader(),
        likesManager: LikesManagerProtocol = LikesManager.shared
    ) {
        self.regionLoader = regionLoader
        self.likesManager = likesManager
    }
}

extension RegionsListPresenter: RegionsListPresenterProtocol {
    var regionsList: [Region] {
        regions
    }
    
    func didSelectItem(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool) {
        view?.showDetailsViewController(region, currentIndexPath, isLike)
    }
    
    func fetchRegions() {
        view?.startLoading()
        regionLoader.loadRegion { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let regions):
                    self?.regions = regions
                    self?.view?.updateRegions(regions)
                    self?.view?.stopLoading()
                    self?.view?.stopRefreshing()
                case .failure(_):
                    self?.view?.showAlert()
                }
            }
        }
    }
    
    func addLike(_ index: Int) {
        likesManager.addLike(index)
    }
    
    func deleteLike(_ index: Int) {
        likesManager.deleteLike(index)
    }
    
    func setLike(_ index: Int) -> Bool {
        likesManager.isLike(index)
    }
}

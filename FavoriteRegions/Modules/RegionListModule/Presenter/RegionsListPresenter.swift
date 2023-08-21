import Foundation

final class RegionsListPresenter {
    private let regionLoader: RegionsLoaderProtocol
    private let likesManager: LikesManagerProtocol
    
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
    func didSelectItem(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool) {
        view?.showDetailsViewController(region, currentIndexPath, isLike)
    }
    
    func fetchRegions(_ completion: @escaping ([Region]) -> Void) {
        view?.startLoading()
        regionLoader.loadRegion { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let regions):
                    self?.view?.updateRegions(regions)
                    self?.view?.stopLoading()
                    self?.view?.stopRefreshing()
                    completion(regions)
                case .failure(_):
                    self?.view?.showErrorAlert()
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

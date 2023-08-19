import Foundation

protocol RegionsListPresenterProtocol {
    var regionsList: [Region] { get }
    func didSelectItem(_ region: Region)
    func fetchRegions()
}

final class RegionsListPresenter {
    private let regionLoader: RegionsLoaderProtocol
    private var regions = [Region]()
    
    weak var view: RegionsListViewControllerProtocol?
    
    init(regionLoader: RegionsLoaderProtocol = RegionsLoader()) {
        self.regionLoader = regionLoader
    }
}

extension RegionsListPresenter: RegionsListPresenterProtocol {
    var regionsList: [Region] {
        regions
    }
    
    func didSelectItem(_ region: Region) {
        view?.showDetailsViewController(region)
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
}

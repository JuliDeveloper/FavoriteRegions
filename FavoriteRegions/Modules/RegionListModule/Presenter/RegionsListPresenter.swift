//
//  RegionsListPresenter.swift
//  FavoriteRegions
//
//  Created by Julia Romanenko on 18.08.2023.
//

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
        regionLoader.loadRegion { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let regions):
                    self?.regions = regions
                    self?.view?.updateRegions(regions)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

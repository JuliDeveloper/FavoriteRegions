//
//  RegionsListPresenter.swift
//  FavoriteRegions
//
//  Created by Julia Romanenko on 18.08.2023.
//

import Foundation

protocol RegionsListPresenterProtocol {
    var regionsList: [Region] { get }
    func didSelectItem()
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
    
    func didSelectItem() {
        view?.showDetailsViewController()
    }
    
    func fetchRegions() {
        regionLoader.loadRegion { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let regions):
                    self.regions = regions
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

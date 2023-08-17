//
//  RegionsListPresenter.swift
//  FavoriteRegions
//
//  Created by Julia Romanenko on 18.08.2023.
//

import Foundation

protocol RegionsListPresenterProtocol {
    func didSelectItem()
}

final class RegionsListPresenter: RegionsListPresenterProtocol {
    
    weak var view: RegionsListViewControllerProtocol?
    
    func didSelectItem() {
        view?.showDetailsViewController()
    }
}

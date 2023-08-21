import Foundation

protocol DetailsRegionPresenterProtocol {
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func setLike(_ index: Int) -> Bool
}

final class DetailsRegionPresenter {
    private let likesManager: LikesManagerProtocol
    
    weak var view: DetailsRegionViewControllerProtocol?
    
    init(likesManager: LikesManagerProtocol = LikesManager.shared) {
        self.likesManager = likesManager
    }
}

extension DetailsRegionPresenter: DetailsRegionPresenterProtocol {
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

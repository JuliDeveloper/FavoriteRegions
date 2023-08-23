import Foundation

final class DetailsRegionPresenter {
    private let likesManager: LikesManagerProtocol
    
    weak var view: DetailsRegionViewProtocol?
        
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
    
    func backToRootViewController() {
        view?.backToRegionsCollection()
    }
    
    func showSelectedImageView(_ imageName: String) {
        view?.showSelectedImage(imageName)
    }
}

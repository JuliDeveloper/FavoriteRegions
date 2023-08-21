import Foundation

final class DetailsRegionPresenter {
    private let likesManager: LikesManagerProtocol
        
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

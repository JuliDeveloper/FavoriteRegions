import Foundation

protocol DetailsRegionPresenterProtocol {
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func setLike(_ index: Int) -> Bool
    func backToRootViewController()
    func showSelectedImageView(_ imageName: String)
}

protocol DetailsRegionViewProtocol: AnyObject {
    func backToRegionsCollection()
    func showSelectedImage(_ imageName: String)
}

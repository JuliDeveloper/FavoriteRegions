import Foundation

protocol DetailsRegionPresenterProtocol {
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func setLike(_ index: Int) -> Bool
}

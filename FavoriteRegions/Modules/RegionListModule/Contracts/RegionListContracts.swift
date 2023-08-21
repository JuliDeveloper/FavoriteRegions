import Foundation

protocol RegionsListViewControllerProtocol: AnyObject {
    func showDetailsViewController(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool)
    func updateRegions(_ regions: [Region])
    func startLoading()
    func stopLoading()
    func stopRefreshing()
    func showErrorAlert()
}

protocol RegionsListPresenterProtocol {
    func didSelectItem(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool)
    func fetchRegions(_ completion: @escaping ([Region]) -> Void)
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func setLike(_ index: Int) -> Bool
}

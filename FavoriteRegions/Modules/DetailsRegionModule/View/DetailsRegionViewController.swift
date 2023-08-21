import UIKit

protocol DetailsRegionViewControllerProtocol: AnyObject {
    
}

final class DetailsRegionViewController: UIViewController {
    
    private let customView = DetailsRegionView()
    
    var region: Region?
    var presenter: DetailsRegionPresenterProtocol?
    var indexPath: IndexPath?
    var isLike = false
    
    weak var delegate: RegionsListViewControllerDelegate?
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.likeButtonTapped = { [weak self] in
            self?.handleLikeButtonTapped()
        }
        
        if let region {
            customView.configure(region, isLike)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    private func setupNavBar() {
        let regionTitle = region?.title ?? ""
        title = "\(regionTitle)"
        navigationController?.navigationBar.prefersLargeTitles = false

        let backButton = UIBarButtonItem(image: UIImage(named: "chevron.left"), style: .done, target: self, action: #selector(backToCollection))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func handleLikeButtonTapped() {
        if let indexPath {
            if isLike {
                presenter?.deleteLike(indexPath.row)
                customView.setUnlikeState()
                delegate?.didChangeLikeStatus(indexPath.row, isLike)
            } else {
                presenter?.addLike(indexPath.row)
                customView.setLikeState()
                delegate?.didChangeLikeStatus(indexPath.row, isLike)
            }
        }
    }
    
    @objc private func backToCollection() {
        navigationController?.popViewController(animated: true)
    }
}

import UIKit

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
        
        if let region = region {
            customView.configure(region, isLike)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateCollectionView(indexPath ?? IndexPath())
    }
    
    private func setupNavBar() {
        let regionTitle = region?.title ?? ""
        title = "\(regionTitle)"
        navigationController?.navigationBar.prefersLargeTitles = false

        let backButton = UIBarButtonItem(
            image: UIImage(named: "chevron.left"),
            style: .done,
            target: self,
            action: #selector(backToCollection)
        )
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func handleLikeButtonTapped() {
        guard let indexPath = indexPath else { return }
        
        if isLike {
            presenter?.deleteLike(indexPath.row)
        } else {
            presenter?.addLike(indexPath.row)
        }
        
        isLike.toggle()
        customView.setLikeButtonState(isLiked: isLike)
        delegate?.toggleLikeState(indexPath, isLike)
    }
    
    @objc private func backToCollection() {
        navigationController?.popViewController(animated: true)
    }
}

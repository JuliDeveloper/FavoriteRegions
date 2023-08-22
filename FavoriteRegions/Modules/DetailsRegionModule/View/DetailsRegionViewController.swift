import UIKit

protocol DetailsRegionViewControllerDelegate: AnyObject {
    func navigateSelectedImageViewController(_ imageName: String)
}

final class DetailsRegionViewController: UIViewController {
    
    private let customView = DetailsRegionView()
    
    private var region: Region?
    private var presenter: DetailsRegionPresenterProtocol?
    private var indexPath: IndexPath?
    private var isLike = false
    
    weak var delegate: RegionsListViewControllerDelegate?
    
    init(region: Region?, presenter: DetailsRegionPresenterProtocol?, indexPath: IndexPath?, isLike: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.region = region
        self.presenter = presenter
        self.indexPath = indexPath
        self.isLike = isLike
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
        customView.selectedRegionImageDelegate = self
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
        presenter?.backToRootViewController()
    }
}

extension DetailsRegionViewController: DetailsRegionViewProtocol {
    func backToRegionsCollection() {
        navigationController?.popViewController(animated: true)
    }
    
    func showSelectedImage(_ imageName: String) {
        let selectedImageVC = SelectedImageViewController()
        selectedImageVC.imageName = imageName
        navigationController?.present(selectedImageVC, animated: true)
    }
}

extension DetailsRegionViewController: DetailsRegionViewControllerDelegate {
    func navigateSelectedImageViewController(_ imageName: String) {
        presenter?.showSelectedImageView(imageName)
    }
}

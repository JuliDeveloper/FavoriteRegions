import UIKit

private let regionImageCellIdentifier = "regionImageCell"

protocol RegionsListViewDelegate: AnyObject {
    func reloadCollectionView()
    func updateCollectionView()
    func navigateDetailsViewController(_ region: Region)
}

final class RegionsListView: UIView {
    
    private lazy var collectionView: RegionCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = RegionCollectionView(
            frame: .zero, collectionViewLayout: layout, isListVC: true
        )
        view.navigateDelegate = self
        return view
    }()
    
    var regions: [Region] = [] {
        didSet {
            collectionView.allRegions = regions
        }
    }
        
    weak var delegate: RegionsListViewControllerDelegate?
    
    init() {
        super.init(frame: .zero)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .frBackgroundColor
        //showScenario()
    }
    
    private func addElements() {
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func showScenario() {
        if regions.isEmpty {
            collectionView.layer.opacity = 0
        } else {
            collectionView.layer.opacity = 1
        }
    }
}

extension RegionsListView: RegionsListViewDelegate {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func updateCollectionView() {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let cell = collectionView.cellForItem(at: selectedIndexPath)
            cell?.layer.borderWidth = Constants.WidthBorder.deselected
        }
    }
    
    func navigateDetailsViewController(_ region: Region) {
        delegate?.navigateDetailsViewController(region)
    }
}

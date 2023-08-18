import UIKit

private let regionImageCellIdentifier = "regionImageCell"

protocol RegionsListViewDelegate: AnyObject {
    func updateCollectionView()
    func navigateDetailsViewController()
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
    
    private var regions = [Region]()
        
    weak var delegate: RegionsListViewControllerDelegate?
    
    func configure(_ regions: [Region]) {
        backgroundColor = .frBackgroundColor
        
        self.regions = regions
        
        addElements()
        setupConstraints()
    }
    
    func addElements() {
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension RegionsListView: RegionsListViewDelegate {
    func updateCollectionView() {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let cell = collectionView.cellForItem(at: selectedIndexPath)
            cell?.layer.borderWidth = Constants.WidthBorder.deselected
        }
    }
    
    func navigateDetailsViewController() {
        delegate?.navigateDetailsViewController()
    }
}

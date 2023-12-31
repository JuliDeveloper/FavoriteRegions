import UIKit

protocol RegionsListViewDelegate: AnyObject {
    func reloadCollectionView()
    func updateCollectionView(_ selectedIndexPath: IndexPath)
    func reloadCollectionViewCell(_ indexPath: IndexPath)
    func navigateDetailsViewController(_ region: Region, _  currentIndexPath: IndexPath?, _ isLike: Bool)
    func startActivityIndicator()
    func stopActivityIndicator()
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func isLike(_ index: Int) -> Bool
}

final class RegionsListView: UIView {
    
    private let activeIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var collectionView: RegionCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = RegionCollectionView(
            frame: .zero, collectionViewLayout: layout, isListVC: true
        )
        view.regionListDelegate = self
        view.selectedRegionImageDelegate = nil
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
    }
    
    private func addElements() {
        addSubview(collectionView)
        collectionView.addSubview(activeIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activeIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activeIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension RegionsListView: RegionsListViewDelegate {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func updateCollectionView(_ selectedIndexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: selectedIndexPath)
        cell?.layer.borderWidth = Constants.WidthBorder.deselected
    }
    
    func reloadCollectionViewCell(_ indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    func navigateDetailsViewController(_ region: Region, _ currentIndexPath: IndexPath?, _ isLike: Bool) {
        delegate?.navigateDetailsViewController(region, currentIndexPath, isLike)
    }
    
    func startActivityIndicator() {
        activeIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activeIndicator.stopAnimating()
    }
    
    func addLike(_ index: Int) {
        delegate?.addLike(index)
    }
    
    func deleteLike(_ index: Int) {
        delegate?.deleteLike(index)
    }
    
    func isLike(_ index: Int) -> Bool {
        guard let result = delegate?.isLike(index) else { return false }
        return result
    }
}

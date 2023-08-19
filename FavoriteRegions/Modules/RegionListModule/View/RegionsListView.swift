import UIKit

private let regionImageCellIdentifier = "regionImageCell"

protocol RegionsListViewDelegate: AnyObject {
    func reloadCollectionView()
    func updateCollectionView()
    func navigateDetailsViewController(_ region: Region)
    func startActivityIndicator()
    func stopActivityIndicator()
    func stopRefreshControl()
}

final class RegionsListView: UIView {
    
    private let activeIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshWeatherData), for: .valueChanged)
        return control
    }()
    
    private lazy var collectionView: RegionCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = RegionCollectionView(
            frame: .zero, collectionViewLayout: layout, isListVC: true
        )
        view.navigateDelegate = self
        view.refreshControl = refreshControl
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
        addSubview(activeIndicator)
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activeIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activeIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func refreshWeatherData() {
        delegate?.reloadFetchRegions()
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
    
    func startActivityIndicator() {
        activeIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activeIndicator.stopAnimating()
    }
    
    func stopRefreshControl() {
        refreshControl.endRefreshing()
    }
}

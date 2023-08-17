import UIKit

private let regionImageCellIdentifier = "regionImageCell"

protocol RegionsListViewDelegate: AnyObject {
    func updateCollectionView()
}

final class RegionsListView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()
        )
        view.dataSource = self
        view.delegate = self
        view.register(
            RegionCollectionViewCell.self,
            forCellWithReuseIdentifier: regionImageCellIdentifier
        )
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private var regions = [Region]()
    
    private let params = GeometricParams(
        cellCount: 2,
        leftInset: 16,
        rightInset: 16,
        cellSpacing: 8
    )
    
    private var selectedIndexPath: IndexPath?
    
    weak var delegate: RegionsListViewControllerDelegate?
    
    func configure() {
        backgroundColor = .frBackgroundColor
        
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

extension RegionsListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: regionImageCellIdentifier, for: indexPath) as? RegionCollectionViewCell
        else { return UICollectionViewCell() }
        
        //let region = regions[indexPath.row]
        cell.configure()
        
        return cell
    }
}

extension RegionsListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth =  availableWidth / CGFloat(params.cellCount)
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: params.leftInset, bottom: 0, right: params.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
}

extension RegionsListView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            let cell = collectionView.cellForItem(at: selectedIndexPath ?? IndexPath())
            cell?.layer.borderWidth = 0
        }
        
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 4
        cell?.layer.borderColor = UIColor.frPurpleColor.cgColor
        
        delegate?.navigateDetailsViewController()
    }
}

extension RegionsListView: RegionsListViewDelegate {
    func updateCollectionView() {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let cell = collectionView.cellForItem(at: selectedIndexPath)
            cell?.layer.borderWidth = 0
        }
    }
}

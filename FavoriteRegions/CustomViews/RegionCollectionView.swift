import UIKit

private let regionImageCellIdentifier = "regionImageCell"

final class RegionCollectionView: UICollectionView {
    
    private var regions = [Region]()
    private let params = GeometricParams(
        cellCount: 2,
        leftInset: 16,
        rightInset: 16,
        cellSpacing: 8
    )
    private var selectedIndexPath: IndexPath?
    weak var navigateDelegate: RegionsListViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCollectionView()
    }
    
//    func updateRegions(_ newRegions: [Region]) {
//        self.regions = newRegions
//        reloadData()
//    }
    
    private func setupCollectionView() {
        register(RegionCollectionViewCell.self, forCellWithReuseIdentifier: regionImageCellIdentifier)
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        
        dataSource = self
        delegate = self
    }
}

extension RegionCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: regionImageCellIdentifier, for: indexPath) as? RegionCollectionViewCell
        else { return UICollectionViewCell() }
        
        //let region = regions[indexPath.row]
        cell.configure(true)
        
        return cell
    }
}

extension RegionCollectionView: UICollectionViewDelegateFlowLayout {
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

extension RegionCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath != nil {
            let cell = collectionView.cellForItem(at: selectedIndexPath ?? IndexPath())
            cell?.layer.borderWidth = 0
        }
        
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 4
        cell?.layer.borderColor = UIColor.frPurpleColor.cgColor
        
        navigateDelegate?.navigateDetailsViewController()
    }
}

import UIKit

final class RegionCollectionView: UICollectionView {
    
    private let params = GeometricParams(
        cellCount: Constants.ParamsCollectionView.cellCount,
        leftInset: Constants.ParamsCollectionView.sideInset,
        rightInset: Constants.ParamsCollectionView.sideInset,
        cellSpacing: Constants.ParamsCollectionView.cellSpacing
    )
    
    private var isListVC: Bool
    private var selectedIndexPath: IndexPath?
    
    var allRegions: [Region] = [] {
        didSet {
            reloadData()
        }
    }

    var selectedRegionImages: [String] = [] {
        didSet {
            reloadData()
        }
    }
        
    weak var navigateDelegate: RegionsListViewDelegate?
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, isListVC: Bool) {
        self.isListVC = isListVC
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        register(
            RegionCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.Identifier.regionImageCellIdentifier
        )
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        
        dataSource = self
        delegate = self
    }
}

extension RegionCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isListVC ? allRegions.count : selectedRegionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: Constants.Identifier.regionImageCellIdentifier,
                for: indexPath
            ) as? RegionCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        if isListVC {
            let region = allRegions[indexPath.row]
            cell.configure(region, isListVC)
            
            let isLike = navigateDelegate?.isLike(indexPath.row) ?? false
            
            if isLike {
                cell.setLikeState()
            } else {
                cell.setUnlikeState()
            }
            
            cell.likeButtonTapped = { [weak self] in
                let currentIsLike = self?.navigateDelegate?.isLike(indexPath.row) ?? false

                if currentIsLike {
                    self?.navigateDelegate?.deleteLike(indexPath.row)
                    cell.setUnlikeState()
                } else {
                    self?.navigateDelegate?.addLike(indexPath.row)
                    cell.setLikeState()
                }
            }
        } else {
            let image = selectedRegionImages[indexPath.row]
            cell.configure(image)
        }
        
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
        UIEdgeInsets(top: params.leftInset, left: params.leftInset, bottom: 0, right: params.rightInset)
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
            cell?.layer.borderWidth = Constants.WidthBorder.deselected
        }
        
        selectedIndexPath = indexPath
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = Constants.WidthBorder.selected
        cell?.layer.borderColor = UIColor.frPurpleColor.cgColor
        
        if isListVC {
            let currentRegion = allRegions[indexPath.row]
            let currentLike = navigateDelegate?.isLike(indexPath.row) ?? false
            navigateDelegate?.navigateDetailsViewController(currentRegion, indexPath, currentLike)
        }
    }
}

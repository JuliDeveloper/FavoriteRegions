import UIKit

protocol DetailsRegionViewDelegate: AnyObject {
    func showSelectedImageViewController(_ imageName: String)
}

final class DetailsRegionView: UIView {
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.layoutMargins = Constants.DetailsView.layoutMarginsHeaderStack
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .frBackgroundColor
        stack.layer.cornerRadius = Constants.Radius.big
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = Constants.DetailsView.shadowOpacityHeaderStack
        stack.layer.shadowOffset = .zero
        stack.layer.shadowRadius = Constants.Radius.big
        return stack
    }()
    
    private let viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = Constants.DetailsView.viewsStackSpacing
        return stack
    }()
    
    private let viewsImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "views")
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .frSubtitle
        label.textColor = .frTextColor.withAlphaComponent(Constants.DetailsView.viewsLabelOpacity)
        return label
    }()
    
    private let likeButton = LikeButton()
    
    private lazy var collectionView: RegionCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = RegionCollectionView(
            frame: .zero, collectionViewLayout: layout, isListVC: false
        )
        view.regionListDelegate = nil
        view.selectedRegionImageDelegate = self
        return view
    }()
    
    var likeButtonTapped: (() -> Void)?
    
    weak var selectedRegionImageDelegate: DetailsRegionViewControllerDelegate?
    
    init() {
        super.init(frame: .zero)
        addElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ region: Region, _ isLike: Bool) {
        setupViews(region)
        setLikeButtonState(isLiked: isLike)
    }
    
    func setLikeButtonState(isLiked: Bool) {
        let imageName = isLiked ? "activeIsLike" : "noActiveIsLike"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func setupViews(_ region: Region) {
        backgroundColor = .frBackgroundColor

        collectionView.selectedRegionImages = region.thumbUrls
        viewsLabel.text = "\(region.viewsCount)"
        likeButton.addTarget(
            self,
            action: #selector(changeIsLike),
            for: .touchUpInside
        )
    }
    
    private func addElements() {
        addSubview(generalStack)
        
        [
            headerStack,
            collectionView
        ].forEach { generalStack.addArrangedSubview($0) }
        
        [
            viewsStack,
            likeButton
        ].forEach { headerStack.addArrangedSubview($0) }
        
        [
            viewsImageView,
            viewsLabel
        ].forEach { viewsStack.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            generalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            generalStack.topAnchor.constraint(equalTo: topAnchor),
            generalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            generalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc private func changeIsLike() {
        likeButtonTapped?()
    }
}

extension DetailsRegionView: DetailsRegionViewDelegate {
    func showSelectedImageViewController(_ imageName: String) {
        selectedRegionImageDelegate?.navigateSelectedImageViewController(imageName)
    }
}

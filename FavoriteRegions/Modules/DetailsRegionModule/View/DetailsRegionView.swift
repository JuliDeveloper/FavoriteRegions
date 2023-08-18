import UIKit

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
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.backgroundColor = .frBackgroundColor
        stack.layer.cornerRadius = 20
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOpacity = 0.2
        stack.layer.shadowOffset = .zero
        stack.layer.shadowRadius = 20
        return stack
    }()
    
    private let viewsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
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
        label.text = "111"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .frTextColor.withAlphaComponent(0.3)
        return label
    }()
    
    private lazy var likeButton = LikeButton()
    
    private lazy var collectionView: RegionCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = RegionCollectionView(
            frame: .zero, collectionViewLayout: layout, isListVC: false
        )
        view.navigateDelegate = nil
        return view
    }()
    
    private var isLike = false
    
    func configure() {
        backgroundColor = .frBackgroundColor
        
        likeButton.addTarget(self, action: #selector(changeIsLike), for: .touchUpInside)
        
        addElements()
        setupConstraints()
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
        isLike.toggle()
        
        if isLike {
            likeButton.setImage(UIImage(named: "activeIsLike"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "noActiveIsLike"), for: .normal)
        }
    }
}

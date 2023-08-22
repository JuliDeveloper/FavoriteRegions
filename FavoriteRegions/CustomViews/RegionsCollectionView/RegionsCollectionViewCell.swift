import UIKit
import Kingfisher

final class RegionCollectionViewCell: UICollectionViewCell {
    
    private let regionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            likeButton,
            regionTitleView
        ])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let regionTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .frBackgroundColor.withAlphaComponent(0.5)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = Constants.Radius.small
        return view
    }()
    
    private let regionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .frSubtitleBold
        label.text = "Regions"
        label.textColor = .frTextColor
        label.numberOfLines = Constants.CollectionViewCell.regionTitleLabelNumberOfLines
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeButton = LikeButton()
    
    var likeButtonTapped: (() -> Void)?
    
    func generalConfigure(_ isList: Bool) {
        setCellConfig()
        defaultUIConfig()
        
        if isList {
            addElements()
            setupConstraints()
        }
    }
        
    func configure(_ region: Region) {
        regionTitleLabel.text = region.title
        
        likeButton.addTarget(
            self,
            action: #selector(changeIsLike),
            for: .touchUpInside
        )
        
        setImage(region.thumbUrls[0])
    }
    
    func configure(_ image: String) {
        setImage(image)
    }
    
    func setLikeButtonState(isLiked: Bool) {
        let imageName = isLiked ? "activeIsLike" : "noActiveIsLike"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension RegionCollectionViewCell {
    @objc private func changeIsLike() {
        likeButtonTapped?()
    }
    
    private func setCellConfig() {
        backgroundColor = .frDarkGray
        layer.cornerRadius = Constants.Radius.regular
        clipsToBounds = true
    }
    
    private func defaultUIConfig() {
        contentView.addSubview(regionImageView)
                
        NSLayoutConstraint.activate([
            regionImageView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            regionImageView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            regionImageView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            regionImageView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
    }
    
    private func setImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        regionImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholder")
        )
    }
    
    private func addElements() {
        contentView.addSubview(mainStackView)
        regionTitleView.addSubview(regionTitleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            mainStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
            
            regionTitleView.leadingAnchor.constraint(
                equalTo: mainStackView.leadingAnchor
            ),
            regionTitleView.trailingAnchor.constraint(
                equalTo: mainStackView.trailingAnchor
            ),
            regionTitleView.bottomAnchor.constraint(
                equalTo: mainStackView.bottomAnchor
            ),
            
            regionTitleLabel.leadingAnchor.constraint(
                equalTo: regionTitleView.leadingAnchor,
                constant: Constants.Constraints.cellConstraints
            ),
            regionTitleLabel.trailingAnchor.constraint(
                equalTo: regionTitleView.trailingAnchor,
                constant: -Constants.Constraints.cellConstraints
            ),
            regionTitleLabel.topAnchor.constraint(
                equalTo: regionTitleView.topAnchor,
                constant: 5
            ),
            regionTitleLabel.bottomAnchor.constraint(
                equalTo: regionTitleView.bottomAnchor,
                constant: -5
            )
        ])
    }
}

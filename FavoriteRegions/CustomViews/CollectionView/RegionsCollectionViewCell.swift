import UIKit
import Kingfisher

final class RegionCollectionViewCell: UICollectionViewCell {
    
    private let regionImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .trailing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let regionTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.text = "Regions"
        label.textColor = .frTextColor
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likeButton = LikeButton()
    
    private var isLike = false
    
    func configure(_ region: Region, _ isListVC: Bool) {
        setCellConfig()
        
        regionTitleLabel.text = region.title
        
        likeButton.addTarget(self, action: #selector(changeIsLike), for: .touchUpInside)
        
        defaultUIConfig()
        setImage(region.thumbUrls[0])
        
        addElements()
        setupConstraints()
        
    }
    
    func configure(_ image: String) {
        setCellConfig()
        
        defaultUIConfig()
        setImage(image)
    }
    
    private func setCellConfig() {
        backgroundColor = .frDarkGray
        layer.cornerRadius = Constants.Radius.cell
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
        guard
            let url = URL(string: imageUrl)
        else {
            return
        }
        
        regionImageView.kf.setImage(
            with: url
        )
    }
    
    private func addElements() {
        contentView.addSubview(mainStackView)
        
        [
            likeButton,
            regionTitleLabel
        ].forEach {
            mainStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.Constraints.cellConstraints
            ),
            mainStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.Constraints.cellConstraints
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constants.Constraints.cellConstraints
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.Constraints.cellConstraints
            ),
            
            regionTitleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            regionTitleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
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

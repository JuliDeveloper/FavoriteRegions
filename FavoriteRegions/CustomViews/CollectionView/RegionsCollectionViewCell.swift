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
    
    private let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gradient = CAGradientLayer()
    
    private var isLike = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = gradientView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gradient.removeFromSuperlayer()
    }
    
    func configure(_ region: Region, _ isListVC: Bool) {
        setCellConfig()
        
        regionTitleLabel.text = region.title
        
        likeButton.addTarget(self, action: #selector(changeIsLike), for: .touchUpInside)
        
        defaultUIConfig()
        setImage(region.thumbUrls[0])
        
        addElements()
        setupConstraints()
        setupGradient()
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
        contentView.addSubview(gradientView)
                
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
            ),
            
            gradientView.heightAnchor.constraint(
                equalToConstant: 50
            ),
            gradientView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            gradientView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            gradientView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            )
        ])
        
        gradientView.layer.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    private func setupGradient() {
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.frBackgroundColor.withAlphaComponent(0).cgColor,
                           UIColor.frBackgroundColor.withAlphaComponent(0.5).cgColor]
        gradientView.layer.insertSublayer(gradient, at: 1)
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

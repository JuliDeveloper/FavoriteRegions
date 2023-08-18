import UIKit

final class RegionCollectionViewCell: UICollectionViewCell {

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
    
    func configure(_ isListVC: Bool) {
        backgroundColor = .frDarkGray
        layer.cornerRadius = Constants.Radius.cell
        
        likeButton.addTarget(self, action: #selector(changeIsLike), for: .touchUpInside)

        if isListVC {
            addElements()
            setupConstraints()
        }
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

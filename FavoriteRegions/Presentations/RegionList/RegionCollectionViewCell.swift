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
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "noActiveIsLike"), for: .normal)
        button.tintColor = .frGrayColor
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(changeIsLike), for: .touchUpInside)
        return button
    }()
    
    private var isLike = false
    
    func configure() {
        backgroundColor = .frDarkGray
        layer.cornerRadius = 16
        
        addElements()
        setupConstraints()
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
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
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

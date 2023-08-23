import UIKit
import Kingfisher

final class SelectedImageView: UIView {
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func configure(_ imageName: String) {
        setImage(imageName)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .frBackgroundColor
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setImage(_ imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url
        )
    }
}

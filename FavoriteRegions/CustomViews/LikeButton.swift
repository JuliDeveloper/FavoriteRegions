import UIKit

final class LikeButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setImage(UIImage(named: Constants.LikeImages.noActiveIsLike), for: .normal)
        tintColor = .frGrayColor
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

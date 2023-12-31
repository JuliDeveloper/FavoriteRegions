import UIKit

struct Constants {
    
    static let url = "https://vmeste.wildberries.ru/api/guide-service/v1/getBrands"
    
    struct ParamsCollectionView {
        static let cellCount = 2
        static let sideInset: CGFloat = 16
        static let cellSpacing: CGFloat = 8
    }
    
    struct CollectionViewCell {
        static let regionTitleLabelNumberOfLines: Int = 1
    }
    
    struct WidthBorder {
        static let deselected: CGFloat = 0
        static let selected: CGFloat = 2
    }
    
    struct Radius {
        static let regular: CGFloat = 16
        static let big: CGFloat = 20
        static let small: CGFloat = 8
    }
    
    struct Constraints {
        static let cellConstraints: CGFloat = 10
    }
    
    struct Identifier {
        static let regionImageCellIdentifier = "regionImageCell"
    }
    
    struct DetailsView {
        static let layoutMarginsHeaderStack = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        static let shadowOpacityHeaderStack: Float = 0.2
        static let viewsStackSpacing: CGFloat = 5
        static let viewsLabelOpacity: CGFloat = 0.3
    }
    
    struct LikeImages {
        static let activeIsLike = "activeIsLike"
        static let noActiveIsLike = "noActiveIsLike"
    }
}

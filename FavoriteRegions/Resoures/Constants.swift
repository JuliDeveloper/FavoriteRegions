//
//  Constants.swift
//  FavoriteRegions
//
//  Created by Julia Romanenko on 18.08.2023.
//

import UIKit

struct Constants {
    struct ParamsCollectionView {
        static let cellCount = 2
        static let sideInset: CGFloat = 16
        static let cellSpacing: CGFloat = 8
    }
    
    struct WidthBorder {
        static let deselected: CGFloat = 0
        static let selected: CGFloat = 4
    }
    
    struct Radius {
        static let cell: CGFloat = 16
    }
    
    struct Constraints {
        static let cellConstraints: CGFloat = 10
    }
    
    struct Identifier {
        static let regionImageCellIdentifier = "regionImageCell"
    }
}

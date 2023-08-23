import Foundation

struct RegionListResult: Decodable {
    let brands: [RegionResult]
}

struct RegionResult: Decodable {
    let brandId: String
    let title: String
    let thumbUrls: [String]
    let tagIds: [String]
    let slug: String
    let type: String
    let viewsCount: Int
    
    func convert() -> Region {
        Region(
            brandId: self.brandId,
            title: self.title,
            thumbUrls: self.thumbUrls,
            viewsCount: self.viewsCount
        )
    }
}

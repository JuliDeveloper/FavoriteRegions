import Foundation

protocol LikesManagerProtocol {
    func addLike(_ index: Int)
    func deleteLike(_ index: Int)
    func isLike(_ index: Int) -> Bool
}

final class LikesManager {
    static let shared = LikesManager()
    private init() {}
    
    private var likesIndex: Set<Int> = []
}

extension LikesManager: LikesManagerProtocol {
    func addLike(_ index: Int) {
        likesIndex.insert(index)
    }
    
    func deleteLike(_ index: Int) {
        likesIndex.remove(index)
    }
    
    func isLike(_ index: Int) -> Bool {
        likesIndex.contains(index)
    }
}

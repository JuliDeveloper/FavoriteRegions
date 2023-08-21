import Foundation

protocol RegionsLoaderProtocol {
    func loadRegion(_ completion: @escaping (Result<[Region], Error>) -> Void)
}

final class RegionsLoader {
    private let networkClient: NetworkClientProtocol
    
    private var favoriteRegionsUrl: URL {
        guard let url = URL(string: Constants.url) else {
            preconditionFailure("Unable to construct regions")
        }
        return url
    }
    
    init(networkClient: NetworkClientProtocol = NetworkClient()) {
         self.networkClient = networkClient
     }
}

extension RegionsLoader: RegionsLoaderProtocol {
    func loadRegion(_ completion: @escaping (Result<[Region], Error>) -> Void) {
        networkClient.fetch(url: favoriteRegionsUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(RegionListResult.self, from: data)
                    
                    var regions = [Region]()
                    json.brands.forEach { regions.append($0.convert()) }
                    completion(.success(regions))
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

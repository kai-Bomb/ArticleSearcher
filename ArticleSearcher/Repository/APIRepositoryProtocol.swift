
import Foundation

protocol APIRepositoryProtocol {
    func fetch(query: String) async throws -> [Article]
}

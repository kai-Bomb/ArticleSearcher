
import Foundation

class MockAPIRepository: APIRepositoryProtocol {
    var result: APIError?
    let articles = [
        Article(
            id: "1",
            title: "HelloSwift",
            url: "apple.com",
            user: User(name: "person", profileImageURL: nil))
    ]
    
    func fetch(query: String) async throws -> [Article] {
        if let error = result {
            throw error
        }
        return articles
    }
}


import XCTest
import Combine
@testable import ArticleSearcher

final class ArticleSearcherTests: XCTestCase {
    var apiRepository: MockAPIRepository!
    var config: ArticleConfig!

    override func setUp() {
        super.setUp()
        apiRepository = MockAPIRepository()
        config = ArticleConfig(apiRepository: apiRepository)
    }
    
    func testFetchArticles() async {
        config.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(config.articles[0].title, "HelloSwift")
    }
    
    func testNetWorkError() async {
        apiRepository.result = .networkError
        config.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(config.errorText, Optional(APIError.networkError.title))
    }
    
    func testResponseError() async {
        apiRepository.result = .responseError
        config.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(config.errorText, Optional(APIError.responseError.title))
    }
    
    func testDecodeError() async {
        apiRepository.result = .decodeError
        config.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(config.errorText, Optional(APIError.decodeError.title))
    }
}

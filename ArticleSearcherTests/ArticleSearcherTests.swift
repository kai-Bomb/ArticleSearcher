//
//  ArticleSearcherTests.swift
//  ArticleSearcherTests
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import XCTest
@testable import ArticleSearcher

final class ArticleSearcherTests: XCTestCase {
    var apiRepository: MockAPIRepository!
    var articleConfig: ArticleConfig!

    override func setUp() {
        super.setUp()
        apiRepository = MockAPIRepository()
        articleConfig = ArticleConfig(apiRepository: apiRepository)
    }
    
    func testFetchArticles() async {
        articleConfig.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(articleConfig.articles[0].title, "HelloSwift")
    }
    
    func testNetWorkError() async {
        apiRepository.result = .networkError
        articleConfig.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(articleConfig.errorText, Optional(APIError.networkError.title))
    }
    
    func testResponseError() async {
        apiRepository.result = .responseError
        articleConfig.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(articleConfig.errorText, Optional(APIError.responseError.title))
    }
    
    func testDecodeError() async {
        apiRepository.result = .decodeError
        articleConfig.searchText = "Swift"
        sleep(2)
        XCTAssertEqual(articleConfig.errorText, Optional(APIError.decodeError.title))
    }
}


import XCTest

final class ArticleSearcherUITests: XCTestCase {
    
    func testErrorAlertIsShown() throws {
        let app = XCUIApplication()
        app.launchEnvironment = ["UI_TESTING": "1"]
        app.launch()
        
        let searchField = app.textFields["SearchTextField"]
        XCTAssertTrue(searchField.exists)
        searchField.tap()
        searchField.typeText("test")

        let alert = app.alerts["レスポンスエラー"]
        XCTAssertTrue(alert.waitForExistence(timeout: 1))
        XCTAssertEqual(alert.label, "レスポンスエラー")
        
        alert.buttons["OK"].tap()
    }
}


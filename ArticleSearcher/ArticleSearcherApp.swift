
import SwiftUI

@main
struct ArticleSearcherApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["UI_TESTING"] == "1" {
                let mockAPIRepository = MockAPIRepository()
                mockAPIRepository.result = .responseError
                return HomeView(config: ArticleConfig(apiRepository: mockAPIRepository))
            }
            else {
                return HomeView()
            }
        }
    }
}

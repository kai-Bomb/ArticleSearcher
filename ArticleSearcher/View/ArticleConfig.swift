//
//  ArticleConfig.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import Foundation
import Combine

class ArticleConfig: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var viewFlow: ViewFlow = .empty
    @Published var errorText: String?
    private var cancellables = Set<AnyCancellable>()
    
    private let apiClient: QiitaAPIProtocol
    
    init(apiClient: QiitaAPIProtocol = QiitaAPIClient()) {
        self.apiClient = apiClient
        
        $searchText
            .debounce(for: .milliseconds(900), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { searchText in
                Task {
                    await self.fetchArticles(query: searchText)
                }
            }
            .store(in: &cancellables)
    }
    
    private func fetchArticles(query: String) async {
        if query == "" {
            self.viewFlow = .empty
            return
        }
        do {
            self.viewFlow = .loading
            let articles = try await apiClient.fetch(query: query)
            DispatchQueue.main.async {
                self.articles = articles
                self.viewFlow = .complete
            }
        } catch {
            let error = error as? APIError ?? APIError.unknown
            DispatchQueue.main.async {
                self.articles = []
                self.viewFlow = .empty
                self.errorText = error.title
            }
        }
    }
}

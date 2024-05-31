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
    @Published var errorText: String = ""
    @Published var isShowErrorAlert = false
    
    private var cancellables = Set<AnyCancellable>()
    private let apiRepository: APIRepositoryProtocol
    
    init(apiRepository: APIRepositoryProtocol = APIRepository()) {
        self.apiRepository = apiRepository
        
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { searchText in
                Task {
                    await self.fetchArticles(query: searchText)
                }
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    private func fetchArticles(query: String) async {
        if query == "" {
            self.viewFlow = .empty
            return
        }
        do {
            viewFlow = .loading
            let articles = try await apiRepository.fetch(query: query)
            self.articles = articles
            viewFlow = .complete
        } catch {
            let error = error as? APIError ?? APIError.unknown
            self.articles = []
            viewFlow = .empty
            errorText = error.title
            isShowErrorAlert = true
        }
    }
    
    func didTapCancelButton() {
        searchText = ""
    }
    
    func didTapErrorAlertButton() {
        isShowErrorAlert = false
    }
}

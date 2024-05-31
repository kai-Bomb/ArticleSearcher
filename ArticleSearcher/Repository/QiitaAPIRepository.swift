//
//  QiitaAPIClient.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import Foundation

class APIRepository: APIRepositoryProtocol {
    func fetch(query: String) async throws -> [Article] {
        let urlString = "https://qiita.com/api/v2/items?query=\(query)"
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw APIError.networkError
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.responseError
        }
        guard let result = try? JSONDecoder().decode([Article].self, from: data) else {
            throw APIError.decodeError
        }
        return result
    }
}

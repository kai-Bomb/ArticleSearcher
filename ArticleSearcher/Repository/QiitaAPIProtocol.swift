//
//  QiitaAPIProtocol.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import Foundation

protocol QiitaAPIProtocol {
    func fetch(query: String) async throws -> [Article]
}

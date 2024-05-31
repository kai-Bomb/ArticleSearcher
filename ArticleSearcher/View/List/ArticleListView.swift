//
//  ArticleListView.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import SwiftUI

struct ArticleListView: View {
    @State var articles: [Article]
    @State var article: Article?
    
    var body: some View {
            List(articles) { article in
                Button {
                    self.article = article
                } label: {
                    ListRow(article: article)
                }

            }
            .listStyle(InsetListStyle())
            .fullScreenCover(item: $article) { item in
                SafariView(url: URL(string: item.url)!)
                    .ignoresSafeArea()
            }
        }
}

#Preview {
    HomeView()
}

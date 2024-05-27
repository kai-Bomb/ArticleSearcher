//
//  ListRow.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import SwiftUI

struct ListRow: View {
    let article: Article
    
    var body: some View {
        HStack {
            if let imageUrl = article.user.profileImageURL,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                } placeholder: {
                    ProgressView()
                }
            } else {
                EmptyView()
            }
            Text(article.title)
                .font(.headline)
                .padding(.bottom)
        }
    }
}

#Preview {
    List {
        ListRow(
            article:
                Article(
                    id: "1",
                    title: "title",
                    url: "",
                    user:
                        User(
                            name: "1",
                            profileImageURL: "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/3683048/profile-images/1716701585"
                        )
                )
        )
    }
    .listStyle(InsetListStyle())
}


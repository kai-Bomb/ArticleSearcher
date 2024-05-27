//
//  ContentView.swift
//  ArticleSearcher
//
//  Created by 渡邊魁優 on 2024/05/27.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var config = ArticleConfig()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch config.viewFlow {
                case .empty:
                    empty
                case .loading:
                    loading
                case .complete:
                    complete
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    searchBar
                }
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            TextField("Search Repositories", text: $config.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("cancel") {
                config.searchText = ""
            }
        }
    }
    
    var loading: some View {
        VStack {
            ProgressView()
            Text("searching...")
                .opacity(0.3)
        }
    }
    
    var empty: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 56))
            Text("let's search articles")
                .font(.title)
        }
        .opacity(0.3)
    }
    
    var complete: some View {
        ArticleListView(articles: config.articles)
    }
}

#Preview {
    HomeView()
}

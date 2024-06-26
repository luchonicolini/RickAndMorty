//
//  SearchView+Components.swift
//  RickAndMorty
//
//  Created by Luciano Nicolini on 30/05/2024.
//

import Foundation
import SwiftUI

extension SearchView {
    var searchView: some View {
        ScrollView {
            scrollDetectionView
            ForEach(Array(viewModel.characterList.enumerated()), id: \.offset) { index, character in
                if index != 0 {
                    Divider()
                }
                
                Button {
                    showCharacterDetail = true
                    selectedCharacter = character
                } label:  {
                    ListRow(title: character.name, image: character.image)
                    if viewModel.isLoading {
                        ProgressView()
                            .accentColor(.white)
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .searchViewStyle()
        .coordinateSpace(.named("scrollview"))
        .sheet(isPresented: $showCharacterDetail) {
            CharacterDetailView(character: selectedCharacter)
        }
    }
    
    var scrollDetectionView: some View {
        GeometryReader { proxy in
            let offset = proxy.frame(in: .named("scrollview")).minY
            Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
        }
        .onPreferenceChange(ScrollPreferenceKey.self) { value in
            withAnimation(.easeInOut) {
                let estimatedContentHeight = CGFloat(viewModel.characterList.count * 50)
                let threshold = 0.4 * estimatedContentHeight
                if value <= -threshold {
                    Task {
                        await viewModel.searchCharacter(by: text, isFirstLoad: false)
                    }
                }
            }
        }
    }
    
    var emptyView: some View {
        Text("No results found")
            .searchViewStyle()
    }
}

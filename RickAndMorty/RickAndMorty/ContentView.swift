//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Luciano Nicolini on 30/05/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = NavigationBarModel()
 
    
    var body: some View {
        HomeView(viewModel: HomeViewModel())
            .environmentObject(model)
    }
}

#Preview {
    ContentView()
}

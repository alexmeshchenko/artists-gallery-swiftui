//
//  ContentView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

struct ContentView: View {
    @State private var dataManager = DataManager.shared

    var body: some View {
        NavigationStack {
            ArtistsListView()
                .environment(dataManager) // Swift 6: новый способ передачи данных
        }
    }
}

#Preview {
    ContentView()
}

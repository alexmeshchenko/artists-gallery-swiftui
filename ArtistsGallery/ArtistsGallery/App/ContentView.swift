//
//  ContentView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ArtistsListView()
        }
    }
}

#Preview {
    ContentView()
}

//
//  ArtistsListView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

struct ArtistsListView: View {
    @Environment(DataManager.self) private var dataManager
    @State private var searchText = ""
    @State private var showingAddArtist = false
    
    var filteredArtists: [Artist] {
        dataManager.searchArtists(query: searchText)
    }
    
    var body: some View {
        NavigationStack {
            mainContent
                .navigationTitle("Artists")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingAddArtist = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .sheet(isPresented: $showingAddArtist) {
                    // Пока что пустой sheet
                    Text("Add Artist - Coming Soon")
                        .font(.title)
                        .padding()
                }
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if dataManager.isLoading {
            ProgressView("Loading...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = dataManager.error {
            VStack(spacing: 16) {
                Text("Error")
                    .font(.headline)
                Text(error)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Button("Try again") {
                    dataManager.loadArtists()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List(filteredArtists) { artist in
                NavigationLink(value: artist) {
                    ArtistCardView(artist: artist)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search...")
            .navigationDestination(for: Artist.self) { artist in
                ArtistDetailView(artist: artist)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let dataManager = DataManager()
    return ArtistsListView()
        .environment(dataManager)
}

//
//  DataManager.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import Foundation

// В Swift 6 используем @Observable
@Observable
class DataManager {
    private(set) var artists: [Artist] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    static let shared = DataManager()
    
    private init() {
        loadArtists()
    }
    
    // Загрузка данных из JSON
    func loadArtists() {
        isLoading = true
        error = nil
        
        guard let url = Bundle.main.url(forResource: "artists_works", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            error = "Could not find data file"
            isLoading = false
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let artistsData = try decoder.decode(ArtistsData.self, from: data)
            artists = artistsData.artists
            isLoading = false
        } catch {
            self.error = "Data parsing error: \(error.localizedDescription)"
            isLoading = false
        }
    }
    
    // Добавление нового художника
    func addArtist(_ artist: Artist) {
        artists.append(artist)
    }
    
    // Добавление работы к художнику
    func addArtwork(_ artwork: Artwork, to artist: Artist) {
        if let index = artists.firstIndex(where: { $0.id == artist.id }) {
            artists[index].works.append(artwork)
        }
    }
    
    // Поиск
    func searchArtists(query: String) -> [Artist] {
        if query.isEmpty {
            return artists
        }
        
        return artists.filter { artist in
            artist.searchableText.localizedCaseInsensitiveContains(query) ||
            artist.works.contains { artwork in
                artwork.searchableText.localizedCaseInsensitiveContains(query)
            }
        }
    }
}

// Модель для декодирования JSON
struct ArtistsData: Codable {
    let artists: [Artist]
}

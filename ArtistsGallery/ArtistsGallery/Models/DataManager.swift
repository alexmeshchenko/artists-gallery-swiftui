//
//  DataManager.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import Foundation

// С iOS 17+ используем @Observable
@Observable
final class DataManager {
    private(set) var artists: [Artist] = []
    private(set) var isLoading = false
    private(set) var error: String?
    
    init() {
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
            
            // Преобразуем CodableArtist в Artist
            artists = artistsData.artists.map { codableArtist in
                let artist = Artist(
                    name: codableArtist.name,
                    bio: codableArtist.bio,
                    image: codableArtist.image
                )
                artist.works = codableArtist.works
                return artist
            }
            
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

// MARK: - Codable Models for JSON Decoding

// Модель для декодирования JSON
struct ArtistsData: Codable {
    let artists: [CodableArtist]
}

// Codable версия Artist для декодирования
struct CodableArtist: Codable {
    let name: String
    let bio: String
    let image: String
    let works: [Artwork]
}

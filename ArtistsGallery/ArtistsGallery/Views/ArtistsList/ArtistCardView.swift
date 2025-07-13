//
//  ArtistCardView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//
import SwiftUI

struct ArtistCardView: View {
    let artist: Artist
    
    var body: some View {
        HStack(spacing: 16) {
            // Фото художника из Assets
            if !artist.image.isEmpty {
                Image(artist.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            } else {
                // Fallback если нет изображения
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 70, height: 70)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.gray)
                    )
            }
            
            // Информация о художнике
            VStack(alignment: .leading, spacing: 6) {
                Text(artist.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .foregroundStyle(.primary)
                
                Text(artist.bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                

            }
            
            Spacer()
            
        }
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        List {
            // Примеры с именами из Assets
            ArtistCardView(artist: Artist(
                name: "Pablo Picasso",
                bio: "Spanish painter, sculptor, printmaker, ceramicist, stage designer, poet and playwright who spent most of his adult life in France.",
                image: "0", // Имя из Assets
                works: [
                    Artwork(title: "Guernica", image: "Picasso1", info: "Famous painting"),
                    Artwork(title: "Les Demoiselles d'Avignon", image: "Picasso2", info: "Another masterpiece")
                ]
            ))
            
            ArtistCardView(artist: Artist(
                name: "Vincent van Gogh",
                bio: "Dutch post-Impressionist painter whose work had far-reaching influence on 20th-century art.",
                image: "1", // Имя из Assets
                works: [
                    Artwork(title: "Starry Night", image: "VanGogh1", info: "Iconic painting")
                ]
            ))
            
            // Пример без изображения
            ArtistCardView(artist: Artist(
                name: "Unknown Artist",
                bio: "Artist without image for testing fallback icon.",
                image: "", // Пустое имя
                works: []
            ))
        }
        .listStyle(.plain)
        .navigationTitle("Artists")
    }
}

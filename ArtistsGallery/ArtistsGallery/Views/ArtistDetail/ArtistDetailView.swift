//
//  ArtistDetailView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

struct ArtistDetailView: View {
    let artist: Artist
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Заголовок с фото и именем художника
                headerSection
                
                // Основной контент
                VStack(alignment: .leading, spacing: 24) {
                    // Биография
                    biographySection
                    
                    // Работы
                    worksSection
                }
                .padding()
            }
        }
        .backButton()
        .navigationBarHidden(true)
        .navigationDestination(for: Artwork.self) { artwork in
            ArtworkDetailView(artwork: artwork)
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            // Фото художника на всю ширину
            if !artist.image.isEmpty {
                Image(artist.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .overlay(
                        Image(systemName: "person.fill")
                            .font(.system(size: 80))
                            .foregroundStyle(.gray)
                    )
            }
            
            // Градиент для лучшей читаемости текста
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 300)
            
            // Текст поверх фото
            VStack(alignment: .leading, spacing: 4) {
                Text(artist.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text("Author")
                    .font(.title3)
                    .foregroundStyle(.white.opacity(0.9))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
    
    // MARK: - Biography Section
    private var biographySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Biography")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text(artist.bio)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(2)
        }
    }
    
    // MARK: - Works Section
    private var worksSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Works")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            VStack(spacing: 20) {
                ForEach(artist.works) { artwork in
                    NavigationLink(value: artwork) {
                        ArtworkRowView(artwork: artwork)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        ArtistDetailView(artist: Artist(
            name: "Pablo Picasso",
            bio: "Pablo Ruiz y Picasso (25 October 1881 – 8 April 1973), also known as Pablo Picasso, was a Spanish painter, sculptor, printmaker, ceramicist, stage designer, poet and playwright who spent most of his adult life in France. He is one of the most influential artists of the 20th century, known for co-founding the Cubist movement, the invention of constructed sculpture, the co-invention of collage, and for the wide variety of styles that he helped develop and explore.",
            image: "0",
            works: [
                Artwork(title: "Guernica", image: "Picasso1", info: "Guernica is a large 1937 oil painting by Spanish artist Pablo Picasso."),
                Artwork(title: "The Weeping Woman", image: "Picasso2", info: "The Weeping Woman is an oil on canvas painted by Pablo Picasso in France in 1937."),
                Artwork(title: "Les Demoiselles d'Avignon", image: "Picasso3", info: "A large oil painting created by Pablo Picasso in 1907."),
                Artwork(title: "Girl Before a Mirror", image: "Picasso4", info: "An oil on canvas painting by Pablo Picasso, painted in March 1932.")
            ]
        ))
    }
}

//
//  ArtworkRowView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import SwiftUI

// MARK: - Artwork Row View (for full-width layout)
struct ArtworkRowView: View {
    let artwork: Artwork
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Изображение работы на всю ширину с сохранением пропорций
            if !artwork.image.isEmpty {
                Image(artwork.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .clipShape(.rect(cornerRadius: 12, style: .continuous))
                       
            } else {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color(.systemGray6))
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .overlay {
                        Image(systemName: "photo")
                            .font(.system(size: 40))
                            .foregroundStyle(.secondary)
                    }
            }
            
            // Название работы под изображением
            Text(artwork.title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 4)
        }
    }
}

// MARK: - Preview
#Preview("ArtworkRow") {
    VStack(spacing: 20) {
        // С изображением
        ArtworkRowView(
            artwork: Artwork(
                title: "Guernica",
                image: "Picasso1",
                info: "A powerful anti-war painting"
            )
        )
        
        // Без изображения
        ArtworkRowView(
            artwork: Artwork(
                title: "The Starry Night",
                image: "",
                info: "Van Gogh's masterpiece"
            )
        )
    }
    .padding()
}

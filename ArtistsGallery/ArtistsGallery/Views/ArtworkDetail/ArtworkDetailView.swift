//
//  ArtworkDetailView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

// MARK: - Placeholder for ArtworkDetailView
struct ArtworkDetailView: View {
    let artwork: Artwork
    @State private var showingFullscreen = false
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Изображение работы (неискаженное, необрезанное)
                    artworkImageSection
                    
                    // Текстовая описательная часть
                    artworkInfoSection
                        .padding()
                }
            }
            
            // Кнопка "Развернуть"
            PrimaryButton(title: "Expand") {
                showingFullscreen = true
            }
        }
        .backButton()
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showingFullscreen) {
            FullscreenArtworkView(artwork: artwork)
        }
    }
    
    // MARK: - Artwork Image Section
    private var artworkImageSection: some View {
        Group {
            if !artwork.image.isEmpty {
                Image(artwork.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                    )
            }
        }
    }
    
    // MARK: - Artwork Info Section
    private var artworkInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Название картины
            Text(artwork.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            // Описание картины
            Text(artwork.info)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

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
    @Environment(\.dismiss) private var dismiss
    @State private var showingFullscreen = false
    
    var body: some View {
        ZStack {
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
                expandButton
            }
            // Плавающие кнопки навигации
            floatingNavigationButtons
        }
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $showingFullscreen) {
            FullscreenArtworkView(artwork: artwork)
        }
    }
    
    // MARK: - Floating Navigation Buttons
    private var floatingNavigationButtons: some View {
        VStack {
            HStack {
                // Кнопка "Назад"
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.black.opacity(0.2))
                        .clipShape(Circle())
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 10) // Отступ от верха экрана
            
            Spacer()
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
    
    // MARK: - Expand Button
    private var expandButton: some View {
        Button("Expand") {
            showingFullscreen = true
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 54)
        .background(Color.black)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

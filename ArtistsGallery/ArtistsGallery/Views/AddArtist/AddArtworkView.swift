//
//  AddArtworkView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import SwiftUI

struct AddArtworkView: View {
    let artist: Artist
    @Environment(DataManager.self) private var dataManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var imageURL = ""
    @State private var info = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Information about the picture") {
                    TextField("Title", text: $title)
                    TextField("Image URL", text: $imageURL)
                    TextField("Description", text: $info, axis: .vertical)
                        .lineLimit(3...6)
                }
                
                if !imageURL.isEmpty {
                    Section("Peviewing") {
                        AsyncImage(url: URL(string: imageURL)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 200)
                        }
                        .frame(maxHeight: 200)
                    }
                }
            }
            .navigationTitle("Новая работа")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        saveArtwork()
                    }
                    .disabled(title.isEmpty || imageURL.isEmpty)
                }
            }
        }
    }
    
    private func saveArtwork() {
        let newArtwork = Artwork(title: title, image: imageURL, info: info)
        dataManager.addArtwork(newArtwork, to: artist)
        dismiss()
    }
}

//
//  AddArtistView.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import SwiftUI

struct AddArtistView: View {
    @Environment(DataManager.self) private var dataManager
    @Environment(\.dismiss) private var dismiss
    
    @State private var name = ""
    @State private var bio = ""
    @State private var imageURL = ""
    @State private var works: [Artwork] = []
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Информация о художнике") {
                    TextField("Имя", text: $name)
                    TextField("Биография", text: $bio, axis: .vertical)
                        .lineLimit(3...6)
                    TextField("URL изображения", text: $imageURL)
                }
                
                Section("Работы") {
                    ForEach(works) { artwork in
                        VStack(alignment: .leading) {
                            Text(artwork.title)
                                .font(.headline)
                            Text(artwork.info)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteArtwork)
                    
                    Button("Добавить работу") {
                        works.append(Artwork(title: "Новая работа", image: "", info: ""))
                    }
                }
            }
            .navigationTitle("Новый художник")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        saveArtist()
                    }
                    .disabled(name.isEmpty || bio.isEmpty)
                }
            }
        }
    }
    
    private func deleteArtwork(at offsets: IndexSet) {
        works.remove(atOffsets: offsets)
    }
    
    private func saveArtist() {
        let newArtist = Artist(name: name, bio: bio, image: imageURL, works: works)
        dataManager.addArtist(newArtist)
        dismiss()
    }
}
//
//  ArtistsGalleryApp.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//

import SwiftUI

@main
struct ArtistsGalleryApp: App {
    @State private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataManager)
        }
    }
}

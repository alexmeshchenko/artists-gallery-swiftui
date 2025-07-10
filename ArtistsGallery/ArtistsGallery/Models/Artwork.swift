//
//  Artwork.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import Foundation
import SwiftUI

@Observable
class Artwork: Identifiable, Codable, Hashable {
    let id = UUID()
    var title: String
    var image: String
    var info: String
    
    init(title: String, image: String, info: String) {
        self.title = title
        self.image = image
        self.info = info
    }
    
    // MARK: - Hashable Conformance
        static func == (lhs: Artwork, rhs: Artwork) -> Bool {
            lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    // MARK: - Codable Conformance
       enum CodingKeys: String, CodingKey {
           case title, image, info
       }
       
       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           title = try container.decode(String.self, forKey: .title)
           image = try container.decode(String.self, forKey: .image)
           info = try container.decode(String.self, forKey: .info)
       }
       
       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(title, forKey: .title)
           try container.encode(image, forKey: .image)
           try container.encode(info, forKey: .info)
       }
}

// Для поиска
extension Artwork {
    var searchableText: String {
        "\(title) \(info)"
    }
}

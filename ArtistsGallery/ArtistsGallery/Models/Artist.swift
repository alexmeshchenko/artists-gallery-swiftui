//
//  Artist.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 10.07.25.
//


import Foundation
import SwiftUI

// В Swift 6 используем @Observable вместо ObservableObject
@Observable
class Artist: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var bio: String
    var image: String
    var works: [Artwork]
    
    init(name: String, bio: String, image: String, works: [Artwork] = []) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    // MARK: - Hashable Conformance
    static func == (lhs: Artist, rhs: Artist) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case name, bio, image, works
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        bio = try container.decode(String.self, forKey: .bio)
        image = try container.decode(String.self, forKey: .image)
        works = try container.decode([Artwork].self, forKey: .works)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(bio, forKey: .bio)
        try container.encode(image, forKey: .image)
        try container.encode(works, forKey: .works)
    }
}

// Для поиска
extension Artist {
    var searchableText: String {
        "\(name) \(bio)"
    }
}

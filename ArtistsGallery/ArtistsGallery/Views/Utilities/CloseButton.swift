//
//  CloseButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 13.07.25.
//

import SwiftUI

/// Кнопка закрытия с автоматической адаптацией к теме
struct CloseButton: View {
    let action: () -> Void
    
    var icon: String = "xmark"
    var fontSize: Font = .title2
    var padding: CGFloat = 12
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(fontSize)
                .foregroundColor(.primary)
                .padding(padding)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
    }
}

// MARK: - CloseButton Modifiers
extension CloseButton {
    func icon(_ name: String) -> CloseButton {
        var button = self
        button.icon = name
        return button
    }
    
    func fontSize(_ font: Font) -> CloseButton {
        var button = self
        button.fontSize = font
        return button
    }
    
    func padding(_ padding: CGFloat) -> CloseButton {
        var button = self
        button.padding = padding
        return button
    }
}

// MARK: - CloseButtonOverlay View Modifier
struct CloseButtonOverlay: ViewModifier {
    let position: Position
    let action: () -> Void
    
    enum Position {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
        
        var alignment: Alignment {
            switch self {
            case .topLeading: return .topLeading
            case .topTrailing: return .topTrailing
            case .bottomLeading: return .bottomLeading
            case .bottomTrailing: return .bottomTrailing
            }
        }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: position.alignment) {
                CloseButton(action: action)
                    .padding()
            }
    }
}

// MARK: - View Extension
extension View {
    /// Добавляет кнопку закрытия поверх View
    func closeButton(
        position: CloseButtonOverlay.Position = .topTrailing,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            CloseButtonOverlay(
                position: position,
                action: action
            )
        )
    }
}

// MARK: - Preview
#Preview("CloseButton Auto Theme") {
    VStack(spacing: 40) {
        // Light mode
        VStack {
            Color.green
                .frame(height: 200)
                .closeButton {
                    print("Close tapped")
                }
                .overlay(alignment: .center) {
                    Text("Light Mode")
                        .foregroundColor(.white)
                        .font(.headline)
                }
        }
        .preferredColorScheme(.light)
        
        // Dark mode
        VStack {
            Color.green
                .frame(height: 200)
                .closeButton(position: .topLeading) {
                    print("Close tapped")
                }
                .overlay(alignment: .center) {
                    Text("Dark Mode")
                        .foregroundColor(.white)
                        .font(.headline)
                }
        }
        .preferredColorScheme(.dark)
        
        // Standalone buttons
        HStack(spacing: 20) {
            CloseButton { print("Close") }
            
            CloseButton { print("Chevron") }
                .icon("chevron.down")
            
            CloseButton { print("Custom") }
                .fontSize(.title)
                .padding(16)
        }
        
        Spacer()
    }
    .padding()
}

//
//  BackButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 13.07.25.
//

import SwiftUI

/// Кнопка "Назад" с автоматической адаптацией к теме
struct BackButton: View {
    let action: () -> Void
    
    var icon: String = "arrow.backward"
    var fontSize: Font = .title2
    var fontWeight: Font.Weight = .medium
    var size: CGFloat = 44
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(fontSize)
                .fontWeight(fontWeight)
                .foregroundColor(.primary)
                .frame(width: size, height: size)
                .background(Color(.systemGray5))
                .clipShape(Circle())
        }
    }
}

// MARK: - BackButton Modifiers
extension BackButton {
    func icon(_ name: String) -> BackButton {
        var button = self
        button.icon = name
        return button
    }
    
    func fontSize(_ font: Font) -> BackButton {
        var button = self
        button.fontSize = font
        return button
    }
    
    func fontWeight(_ weight: Font.Weight) -> BackButton {
        var button = self
        button.fontWeight = weight
        return button
    }
    
    func size(_ size: CGFloat) -> BackButton {
        var button = self
        button.size = size
        return button
    }
}

// MARK: - NavigationBackButton View Modifier
struct NavigationBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    var customAction: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                BackButton(action: customAction ?? { dismiss() })
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
            }
    }
}

// MARK: - View Extension
extension View {
    /// Добавляет кнопку "Назад" поверх View
    func backButton(action: (() -> Void)? = nil) -> some View {
        self.modifier(
            NavigationBackButton(customAction: action)
        )
    }
}

// MARK: - Preview
#Preview("BackButton Auto Theme") {
    NavigationView {
        VStack(spacing: 40) {
            // Light mode
            VStack {
                Color.blue
                    .frame(height: 200)
                    .backButton()
                    .overlay(alignment: .center) {
                        Text("Light Mode")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
            }
            .preferredColorScheme(.light)
            
            // Dark mode
            VStack {
                Color.blue
                    .frame(height: 200)
                    .backButton()
                    .overlay(alignment: .center) {
                        Text("Dark Mode")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
            }
            .preferredColorScheme(.dark)
            
            // Standalone buttons
            HStack(spacing: 20) {
                BackButton { print("Back") }
                
                BackButton { print("Chevron") }
                    .icon("chevron.left")
                
                BackButton { print("Close") }
                    .icon("xmark")
                    .size(50)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

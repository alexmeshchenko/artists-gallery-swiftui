//
//  PrimaryButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 12.07.25.
//
//
//  PrimaryButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 12.07.25.
//

import SwiftUI

/// Универсальная кнопка, автоматически адаптирующаяся к теме
struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    
    var font: Font = .headline
    var height: CGFloat = 54
    var cornerRadius: CGFloat = 12
    var horizontalPadding: CGFloat = 16
    var bottomPadding: CGFloat = 16
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(Color(.systemBackground)) // текст инвертирован
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .contentShape(Rectangle())
        }
        .background(Color.primary) // фон — основной цвет системы
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }
}

// MARK: - PrimaryButton Modifiers
extension PrimaryButton {
    func font(_ font: Font) -> PrimaryButton {
        var button = self
        button.font = font
        return button
    }
    
    func height(_ height: CGFloat) -> PrimaryButton {
        var button = self
        button.height = height
        return button
    }
    
    func cornerRadius(_ radius: CGFloat) -> PrimaryButton {
        var button = self
        button.cornerRadius = radius
        return button
    }
    
    func padding(horizontal: CGFloat = 16, bottom: CGFloat = 16) -> PrimaryButton {
        var button = self
        button.horizontalPadding = horizontal
        button.bottomPadding = bottom
        return button
    }
}

// MARK: - Preview
#Preview("PrimaryButton Auto Theme") {
    VStack(spacing: 20) {
        // Light mode preview
        VStack(spacing: 20) {
            Text("Light Mode")
                .font(.headline)
            
            PrimaryButton(title: "Continue") {
                print("Tapped")
            }
            
            PrimaryButton(title: "Confirm") { }
                .cornerRadius(8)
                .height(48)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .preferredColorScheme(.light)
        
        // Dark mode preview
        VStack(spacing: 20) {
            Text("Dark Mode")
                .font(.headline)
            
            PrimaryButton(title: "Continue") {
                print("Tapped")
            }
            
            PrimaryButton(title: "Confirm") { }
                .cornerRadius(8)
                .height(48)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .preferredColorScheme(.dark)
    }
    .padding()
}

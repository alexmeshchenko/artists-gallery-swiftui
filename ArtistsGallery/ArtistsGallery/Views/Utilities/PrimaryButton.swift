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
                .foregroundStyle(Color(.systemBackground)) // текст инвертирован
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .contentShape(.rect)
        }
        .background(.primary) // фон — основной цвет системы
        .clipShape(.rect(cornerRadius: cornerRadius, style: .continuous))
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

// MARK: - Button Style Alternative (iOS 17+)
struct PrimaryButtonStyle: ButtonStyle {
    var height: CGFloat = 54
    var cornerRadius: CGFloat = 12
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Color(.systemBackground))
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(.primary)
            .clipShape(.rect(cornerRadius: cornerRadius, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - View Extension
extension View {
    /// Применяет стиль основной кнопки
    func primaryButtonStyle(height: CGFloat = 54, cornerRadius: CGFloat = 12) -> some View {
        self.buttonStyle(PrimaryButtonStyle(height: height, cornerRadius: cornerRadius))
    }
}

// MARK: - Preview
#Preview("PrimaryButton - Light") {
    VStack(spacing: 20) {
        Text("Light Mode")
            .font(.headline)
        
        // Обычный способ
        PrimaryButton(title: "Continue") {
            print("Tapped")
        }
        
        PrimaryButton(title: "Confirm") { }
            .cornerRadius(8)
            .height(48)
        
        // Альтернативный способ через ButtonStyle
        Button("Alternative Style") {
            print("Alternative tapped")
        }
        .primaryButtonStyle()
        
        Button("Custom Style") {
            print("Custom tapped")
        }
        .primaryButtonStyle(height: 48, cornerRadius: 8)
    }
    .padding()
    .background(Color(.systemBackground))
    .environment(\.colorScheme, .light)
}

#Preview("PrimaryButton - Dark") {
    VStack(spacing: 20) {
        Text("Dark Mode")
            .font(.headline)
        
        PrimaryButton(title: "Continue") {
            print("Tapped")
        }
        
        PrimaryButton(title: "Confirm") { }
            .cornerRadius(8)
            .height(48)
        
        Button("Alternative Style") {
            print("Alternative tapped")
        }
        .primaryButtonStyle()
    }
    .padding()
    .background(Color(.systemBackground))
    .environment(\.colorScheme, .dark)
}

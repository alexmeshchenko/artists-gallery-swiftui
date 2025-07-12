//
//  PrimaryButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 12.07.25.
//



import SwiftUI

/// Основная кнопка приложения с настраиваемыми параметрами
///
/// Готовые стили:
///    .black() - основная кнопка
///    .blue() - акцентная кнопка
///    .red() - деструктивная кнопка
///    .outline() - прозрачная с границей
///
struct PrimaryButton: View {
    // MARK: - Properties
    let title: String
    let action: () -> Void
    
    // MARK: - Customization
    var backgroundColor: Color = .black
    var foregroundColor: Color = .white
    var font: Font = .headline
    var height: CGFloat = 54
    var cornerRadius: CGFloat = 12
    var horizontalPadding: CGFloat = 16
    var bottomPadding: CGFloat = 16
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .contentShape(Rectangle())
        }
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .padding(.horizontal, horizontalPadding)
        .padding(.bottom, bottomPadding)
    }
}

// MARK: - PrimaryButton Extensions
extension PrimaryButton {
    /// Черная кнопка (по умолчанию)
    static func black(
        title: String,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, action: action)
    }
    
    /// Синяя кнопка
    static func blue(
        title: String,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, action: action)
            .backgroundColor(.blue)
    }
    
    /// Красная кнопка (для деструктивных действий)
    static func red(
        title: String,
        action: @escaping () -> Void
    ) -> PrimaryButton {
        PrimaryButton(title: title, action: action)
            .backgroundColor(.red)
    }
    
    /// Прозрачная кнопка с границей
    static func outline(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .contentShape(Rectangle())
        }
        .background(Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
        )
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

// MARK: - PrimaryButton Modifiers
extension PrimaryButton {
    /// Настройка цвета фона
    func backgroundColor(_ color: Color) -> PrimaryButton {
        var button = self
        button.backgroundColor = color
        return button
    }
    
    /// Настройка цвета текста
    func foregroundColor(_ color: Color) -> PrimaryButton {
        var button = self
        button.foregroundColor = color
        return button
    }
    
    /// Настройка шрифта
    func font(_ font: Font) -> PrimaryButton {
        var button = self
        button.font = font
        return button
    }
    
    /// Настройка высоты
    func height(_ height: CGFloat) -> PrimaryButton {
        var button = self
        button.height = height
        return button
    }
    
    /// Настройка скругления углов
    func cornerRadius(_ radius: CGFloat) -> PrimaryButton {
        var button = self
        button.cornerRadius = radius
        return button
    }
    
    /// Настройка отступов
    func padding(horizontal: CGFloat = 16, bottom: CGFloat = 16) -> PrimaryButton {
        var button = self
        button.horizontalPadding = horizontal
        button.bottomPadding = bottom
        return button
    }
}

// MARK: - Preview
#Preview("PrimaryButton Examples") {
    VStack(spacing: 20) {
        // Основная черная кнопка
        PrimaryButton.black(title: "Expand") {
            print("Expand tapped")
        }
        
        // Синяя кнопка
        PrimaryButton.blue(title: "Save") {
            print("Save tapped")
        }
        
        // Красная кнопка
        PrimaryButton.red(title: "Delete") {
            print("Delete tapped")
        }
        
        // Кнопка с настройками
        PrimaryButton(title: "Custom", action: {})
            .backgroundColor(.green)
            .foregroundColor(.white)
            .height(48)
            .cornerRadius(8)
        
        // Прозрачная кнопка
        PrimaryButton.outline(title: "Cancel") {
            print("Cancel tapped")
        }
        
        Spacer()
    }
    .padding()
}

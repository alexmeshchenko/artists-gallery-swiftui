//
//  CloseButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 13.07.25.
//

import SwiftUI

/// Кнопка закрытия с настраиваемыми параметрами
struct CloseButton: View {
    // MARK: - Properties
    let action: () -> Void
    
    // MARK: - Customization
    var icon: String = "xmark"
    var fontSize: Font = .title2
    var foregroundColor: Color = .black
    var backgroundColor: Color = Color.white.opacity(0.6)
    var padding: CGFloat = 12
    var position: Position = .topTrailing
    
    // MARK: - Position Enum
    enum Position {
        case topLeading
        case topTrailing
        case bottomLeading
        case bottomTrailing
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(fontSize)
                .foregroundColor(foregroundColor)
                .padding(padding)
                .background(backgroundColor)
                .clipShape(Circle())
        }
    }
}

// MARK: - CloseButton Extensions
extension CloseButton {
    /// Стандартная кнопка закрытия
    static func standard(action: @escaping () -> Void) -> CloseButton {
        CloseButton(action: action)
    }
    
    /// Темная кнопка закрытия
    static func dark(action: @escaping () -> Void) -> CloseButton {
        CloseButton(action: action)
            .foregroundColor(.white)
            .backgroundColor(Color.black.opacity(0.6))
    }
    
    /// Прозрачная кнопка закрытия
    static func clear(action: @escaping () -> Void) -> CloseButton {
        CloseButton(action: action)
            .backgroundColor(.clear)
    }
}

// MARK: - CloseButton Modifiers
extension CloseButton {
    /// Настройка иконки
    func icon(_ name: String) -> CloseButton {
        var button = self
        button.icon = name
        return button
    }
    
    /// Настройка размера шрифта
    func fontSize(_ font: Font) -> CloseButton {
        var button = self
        button.fontSize = font
        return button
    }
    
    /// Настройка цвета иконки
    func foregroundColor(_ color: Color) -> CloseButton {
        var button = self
        button.foregroundColor = color
        return button
    }
    
    /// Настройка цвета фона
    func backgroundColor(_ color: Color) -> CloseButton {
        var button = self
        button.backgroundColor = color
        return button
    }
    
    /// Настройка внутренних отступов
    func padding(_ padding: CGFloat) -> CloseButton {
        var button = self
        button.padding = padding
        return button
    }
    
    /// Настройка позиции
    func position(_ position: Position) -> CloseButton {
        var button = self
        button.position = position
        return button
    }
}

// MARK: - CloseButtonOverlay View Modifier
struct CloseButtonOverlay: ViewModifier {
    let position: CloseButton.Position
    let action: () -> Void
    var style: CloseButtonStyle = .standard
    
    enum CloseButtonStyle {
        case standard
        case dark
        case clear
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                button
                    .padding()
            }
    }
    
    private var alignment: Alignment {
        switch position {
        case .topLeading: return .topLeading
        case .topTrailing: return .topTrailing
        case .bottomLeading: return .bottomLeading
        case .bottomTrailing: return .bottomTrailing
        }
    }
    
    private var button: CloseButton {
        switch style {
        case .standard:
            return CloseButton.standard(action: action)
        case .dark:
            return CloseButton.dark(action: action)
        case .clear:
            return CloseButton.clear(action: action)
        }
    }
}

// MARK: - View Extension
extension View {
    /// Добавляет кнопку закрытия поверх View
    func closeButton(
        position: CloseButton.Position = .topTrailing,
        style: CloseButtonOverlay.CloseButtonStyle = .standard,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            CloseButtonOverlay(
                position: position,
                action: action,
                style: style
            )
        )
    }
}

// MARK: - Preview
#Preview("CloseButton Examples") {
    VStack(spacing: 40) {
        // Пример 1: Стандартная кнопка
        Color.blue
            .frame(height: 200)
            .closeButton {
                print("Close tapped")
            }
        
        // Пример 2: Темная кнопка слева
        Color.green
            .frame(height: 200)
            .closeButton(position: .topLeading, style: .dark) {
                print("Close tapped")
            }
        
        // Пример 3: Отдельные кнопки
        HStack(spacing: 20) {
            CloseButton.standard {
                print("Standard")
            }
            
            CloseButton.dark {
                print("Dark")
            }
            
            CloseButton.clear {
                print("Clear")
            }
            
            // Кастомная кнопка
            CloseButton(action: { print("Custom") })
                .icon("chevron.down")
                .foregroundColor(.red)
                .backgroundColor(Color.yellow.opacity(0.3))
        }
        
        Spacer()
    }
    .padding()
}

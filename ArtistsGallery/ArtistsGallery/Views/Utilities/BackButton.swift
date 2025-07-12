//
//  BackButton.swift
//  ArtistsGallery
//
//  Created by Aleksandr Meshchenko on 13.07.25.
//

import SwiftUI

/// Кнопка "Назад" с настраиваемыми параметрами
struct BackButton: View {
    // MARK: - Properties
    let action: () -> Void
    
    // MARK: - Customization
    var icon: String = "arrow.backward"
    var fontSize: Font = .title2
    var fontWeight: Font.Weight = .medium
    var foregroundColor: Color = .white
    var backgroundColor: Color = Color.black.opacity(0.2)
    var size: CGFloat = 44
    var isFloating: Bool = true
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(fontSize)
                .fontWeight(fontWeight)
                .foregroundColor(foregroundColor)
                .frame(width: size, height: size)
                .background(isFloating ? backgroundColor : Color.clear)
                .clipShape(Circle())
        }
    }
}

// MARK: - BackButton Extensions
extension BackButton {
    /// Стандартная плавающая кнопка "Назад"
    static func floating(action: @escaping () -> Void) -> BackButton {
        BackButton(action: action)
    }
    
    /// Темная плавающая кнопка "Назад"
    static func darkFloating(action: @escaping () -> Void) -> BackButton {
        BackButton(action: action)
            .backgroundColor(Color.white.opacity(0.2))
            .foregroundColor(.black)
    }
    
    /// Простая кнопка "Назад" без фона
    static func simple(action: @escaping () -> Void) -> BackButton {
        BackButton(action: action)
            .isFloating(false)
            .foregroundColor(.primary)
    }
    
    /// Кнопка "Назад" с chevron
    static func chevron(action: @escaping () -> Void) -> BackButton {
        BackButton(action: action)
            .icon("chevron.left")
    }
}

// MARK: - BackButton Modifiers
extension BackButton {
    /// Настройка иконки
    func icon(_ name: String) -> BackButton {
        var button = self
        button.icon = name
        return button
    }
    
    /// Настройка размера шрифта
    func fontSize(_ font: Font) -> BackButton {
        var button = self
        button.fontSize = font
        return button
    }
    
    /// Настройка толщины шрифта
    func fontWeight(_ weight: Font.Weight) -> BackButton {
        var button = self
        button.fontWeight = weight
        return button
    }
    
    /// Настройка цвета иконки
    func foregroundColor(_ color: Color) -> BackButton {
        var button = self
        button.foregroundColor = color
        return button
    }
    
    /// Настройка цвета фона
    func backgroundColor(_ color: Color) -> BackButton {
        var button = self
        button.backgroundColor = color
        return button
    }
    
    /// Настройка размера кнопки
    func size(_ size: CGFloat) -> BackButton {
        var button = self
        button.size = size
        return button
    }
    
    /// Настройка плавающего стиля
    func isFloating(_ floating: Bool) -> BackButton {
        var button = self
        button.isFloating = floating
        return button
    }
}

// MARK: - NavigationBackButton View Modifier
struct NavigationBackButton: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    var style: BackButtonStyle = .floating
    var customAction: (() -> Void)?
    
    enum BackButtonStyle {
        case floating
        case darkFloating
        case simple
        case chevron
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topLeading) {
                button
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
            }
    }
    
    private var button: BackButton {
        let action = customAction ?? { dismiss() }
        
        switch style {
        case .floating:
            return BackButton.floating(action: action)
        case .darkFloating:
            return BackButton.darkFloating(action: action)
        case .simple:
            return BackButton.simple(action: action)
        case .chevron:
            return BackButton.chevron(action: action)
        }
    }
}

// MARK: - View Extension
extension View {
    /// Добавляет кнопку "Назад" поверх View
    func backButton(
        style: NavigationBackButton.BackButtonStyle = .floating,
        action: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            NavigationBackButton(
                style: style,
                customAction: action
            )
        )
    }
}

// MARK: - Preview
#Preview("BackButton Examples") {
    NavigationView {
        VStack(spacing: 40) {
            // Пример 1: View с кнопкой назад
            Color.blue
                .frame(height: 200)
                .backButton()
                .overlay(alignment: .center) {
                    Text("Default Back Button")
                        .foregroundColor(.white)
                }
            
            // Пример 2: View с темной кнопкой
            Color.yellow
                .frame(height: 200)
                .backButton(style: .darkFloating)
                .overlay(alignment: .center) {
                    Text("Dark Back Button")
                }
            
            // Пример 3: Отдельные кнопки
            HStack(spacing: 20) {
                BackButton.floating {
                    print("Floating")
                }
                
                BackButton.darkFloating {
                    print("Dark")
                }
                
                BackButton.simple {
                    print("Simple")
                }
                
                BackButton.chevron {
                    print("Chevron")
                }
                
                // Кастомная кнопка
                BackButton(action: { print("Custom") })
                    .icon("xmark")
                    .backgroundColor(.red.opacity(0.2))
                    .size(50)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarHidden(true)
    }
}

# Архитектура проекта

## Паттерны и подходы

### MVVM с @Observable
Проект использует паттерн MVVM с новым макросом @Observable:
- **Model**: Artist, Artwork
- **View**: SwiftUI Views
- **ViewModel**: DataManager

### Навигация
- NavigationStack для iOS 16+
- NavigationLink с value-based navigation
- Programmatic navigation через NavigationPath

### Управление состоянием
- @State для локального состояния
- @Observable для shared state
- Environment для передачи данных

## Компоненты

### DataManager
Центральный класс для управления данными:
- Загрузка из JSON
- Поиск и фильтрация
- Добавление новых данных

### Views
- **ArtistsListView**: Главный экран
- **ArtistDetailView**: Детали художника
- **ArtworkDetailView**: Просмотр картины
- **AddArtistView**: Добавление художника
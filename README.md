# Movie DB App
Проект мобильного приложения для сервиса [The Movie Database (TMDb)](https://www.themoviedb.org/).

## Требования
CocoaPods, iOS 12+, Swift 5

## Установка
```
pod install
```

## Структура проекта
```
.
├── Client              # Низкоуровневое сетевое API
├── Persistency         # Слой данных
├── Business Logic      # Слой бизнесс логики, сервисы
├── Model               # Модели, DTO
├── Presentation        # Слой представления, View, View Controller
├── Application         # Всё что связанно с работой приложения, AppDelegate
└── Resources           # Ресурсы: картинки, строки и т.д.
```
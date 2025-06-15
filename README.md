# Fithub Movie App

A modular Flutter movie application with Clean Architecture, GetX state management, and custom theming.

## Features
- Browse, search, and view movie details from TMDB
- Add/remove movies to favorites
- Offline mode (using Hive for local storage)

## Folder Structure
```
lib/
├── app/
│   ├── common/
│   ├── module/
│   └── ...
├── core/
│   ├── exceptions/
│   ├── network/
│   └── storage/
├── data/
│   ├── api/
│   ├── implementation/
│   └── di/
└── main.dart
```

## Tech Stack
- **Flutter 3.29.3**
- **GetX** (state management & navigation)
- **Dio** (networking)
- **Hive** (local storage)
- **Intl** (date formatting)

## Getting Started
1. Clone this repo
2. Run `flutter pub get`
3. Run `flutter pub run build_runner build --delete-conflicting-outputs`
4. Check your email for flavor file and add it to `lib/app/network_flavor/network_flavor.dart`
5. Run with `flutter run`

---

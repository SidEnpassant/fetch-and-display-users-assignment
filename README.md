# Flutter User Directory App

A modern Flutter application demonstrating responsive UI design, state management, and REST API integration. The app features a sleek user interface with glassmorphism design, smooth animations, and robust error handling.

## Features

### 🎯 Core Functionality
- Fetch and display users from REST API
- View detailed user information
- Add new users locally
- Search/filter users
- Responsive design for mobile, tablet, and desktop

### 🎨 UI/UX Features
- Modern glassmorphism design
- Animated page transitions
- Loading animations
- Dark theme with gradient backgrounds
- Responsive grid/list layouts
- Hero animations for user avatars

### 🛠 Technical Implementation
- Provider state management
- REST API integration with error handling
- Form validation
- Responsive layouts using LayoutBuilder
- Clean architecture with separated concerns

## Getting Started

### Prerequisites
- Flutter (latest version)
- Dart SDK
- Android Studio / VS Code
- An emulator or physical device

### Installation

1. Clone the repository
```bash
git clone https://github.com/your-username/flutter-user-directory.git
```
2. Navigate to project directory
```bash
cd flutter-user-directory
```
3. Install dependencies
```bash
flutter pub get
```
4. Run the app
```bash
flutter run
```
Dependencies:
```bash
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  http: ^1.1.0
```
API Reference
The app uses the JSONPlaceholder API:

Endpoint: https://jsonplaceholder.typicode.com/users
Method: GET
Response: List of user objects

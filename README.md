# Task Manager App

A Flutter-based task management application demonstrating modern mobile development practices, clean architecture, and testing patterns.

## Overview

This application allows users to:
- Create, update, and delete tasks
- Sort tasks by priority and due date
- Filter tasks by status (Pending/Completed)
- Change app theme colors
- Store data locally using SQLite

## Technical Stack

- **Framework**: Flutter 3.27.0
- **State Management**: Flutter Bloc
- **Database**: Drift (SQLite)
- **Architecture**: Clean Architecture
- **Testing**: Integration Tests

1. **Flutter Setup**:
   ```bash
   # Install Flutter using Homebrew
   brew install flutter

   # Verify installation
   flutter doctor
   ```

2. **Android Studio Setup**:
   ```bash
   # Install Android Studio using Homebrew
   brew install --cask android-studio
   ```
   
   After installation:
   - Launch Android Studio
   - Complete the setup wizard
   - Install Android SDK (API level 33 or higher)
   - Create an Android Virtual Device (AVD):
     1. Open AVD Manager (Tools > Device Manager)
     2. Click 'Create Virtual Device'
     3. Select a device definition (e.g., Pixel 6)
     4. Download and select a system image (API 33 recommended)
     5. Complete AVD creation


3. **IDE Setup**:
   - Install VS Code from [code.visualstudio.com](https://code.visualstudio.com)
   - Install Flutter extension in VS Code

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone [https://github.com/sidha6th/Task-Manager]
   cd task_manager
   ```

2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate Required Files**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**:
   ```bash
   # For Android Emulator
   flutter emulators --launch <emulator_id>
   flutter run
   ```

## Project Structure

```
lib/
├── core/                # Shared components
│   ├── global/          # Global utilities
│   ├── theme/           # Theme configuration
│   └── utils/           # Utility functions
├── features/            # Feature modules
│   ├── home/            # Home screen
│   └── task_creation/   # Task creation/update
├── app.dart             # App entry point
└── main.dart            # Entry point
```

## Testing

The app includes comprehensive integration tests demonstrating the core functionality:

```bash
# Run all integration tests
flutter test test/integration_test/task_related/task_test.dart

# Run Theme tests
flutter test flutter test --update-goldens

#Handling Test Failures: Database Cleanup If a test fails, 
#delete the database file inside the "task_manager"/support directory.

#Reason:
## Running the test multiple times (5-10+) may cause failures in integration tests.
## This happens because tasks are loaded using pagination. After several test runs, 
## new tasks may only appear after scrolling the list view, which is not currently handled in the test.

```

## Key Features Demonstrated

1. **Clean Architecture**
   - Separation of concerns
   - Dependency injection
   - Repository pattern

2. **State Management**
   - BLoC pattern implementation
   - Reactive programming

3. **Local Storage**
   - SQL database integration
   - Type-safe queries using Drift

4. **UI/UX**
   - Material Design 3
   - Dynamic theming
   - Responsive layout

5. **Testing**
   - Integration testing
   - Widget testing
   - Test helpers and utilities

## Performance Considerations

- Efficient database queries
- Minimal rebuilds using const constructors
- Memory-efficient list views
- Proper disposal of controllers and streams

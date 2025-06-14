# Default Flutter Project

A comprehensive Flutter project showcasing modern architecture patterns, dependency injection, routing, authentication, and storage management with a focus on maintainability, testability, and scalability.

## 🏗️ Architecture Overview

This project implements a **feature-driven architecture** with clear separation of concerns, utilizing dependency injection for loose coupling and comprehensive abstractions for external dependencies.

### Core Principles
- **Dependency Injection**: Centralized dependency management using GetIt with custom abstractions
- **Interface Segregation**: All external dependencies are abstracted through interfaces
- **Testability**: Comprehensive unit test coverage with mocking capabilities
- **Scalability**: Modular structure that grows with your application
- **Type Safety**: Strong typing throughout the application

## 🏛️ Core Systems

### 1. Dependency Injection System (`@/injection`)

A sophisticated dependency injection system built on top of GetIt with scope management and lifecycle control.

**Key Components:**
- `IDependencyInjector`: Core abstraction interface
- `DependencyInjector`: GetIt implementation with scope management
- `BaseInjection`: Abstract base class for setting up dependency groups
- `AppInjections`: Application-wide dependency registration
- `AppInjector`: Global injector instance and convenience methods

**Features:**
- **Scope Management**: Create and manage dependency scopes
- **Lifecycle Control**: Setup and teardown dependency groups
- **Global Access**: Convenient global functions (`get<T>()`, `isRegistered<T>()`)
- **Registration Types**: Singleton, Factory, and Lazy Singleton support

**Example Usage:**
```dart
// Initialize the global injector
await initializeInjector();

// Register dependencies
injector.registerSingleton<MyService>(MyServiceImpl());

// Access dependencies
final service = get<MyService>();
```

### 2. Routing System (`@/router`)

A flexible routing system built on GoRouter with custom abstractions for maintainable navigation.

**Key Components:**
- `BaseAppRoute`: Abstract route definition interface
- `RouteConverter`: Converts custom routes to GoRouter routes
- `IAppRouter`: Router abstraction interface
- `AppRouter`: GoRouter implementation
- `AppRoutes`: Central route configuration

**Features:**
- **Type-Safe Navigation**: Strongly-typed route parameters
- **Nested Routing**: Support for hierarchical route structures
- **Route Guards**: Built-in redirect capabilities
- **Centralized Configuration**: All routes defined in one place
- **Testable**: Router logic is easily unit testable

**Example Usage:**
```dart
// Define a route
class ProfileRoute extends BaseAppRoute {
  @override
  String get path => '/profile/:userId';
  
  @override
  String get name => 'profile';
  
  @override
  RouteBuilder get builder => (context, pathParams, queryParams, extra) {
    return ProfilePage(userId: pathParams['userId']!);
  };
}

// Use in MaterialApp
MaterialApp.router(
  routerConfig: AppRoutes.routerConfig,
)
```

### 3. Authentication System (`@/auth`)

Comprehensive authentication system with secure token management and session persistence.

**Key Components:**
- `IAuthService`: Authentication service interface
- `AuthService`: Complete authentication implementation
- `AuthToken`: Token model with user data
- `UserModel`: User data model

**Features:**
- **Session Management**: Persistent login sessions
- **Token Handling**: Access and refresh token management
- **Secure Storage**: Encrypted token storage
- **State Management**: Authentication state tracking
- **Error Recovery**: Graceful handling of corrupted sessions

**Example Usage:**
```dart
final authService = get<IAuthService>();

// Initialize auth service
await authService.init();

// Save user session
await authService.saveSession(authToken);

// Check authentication state
if (authService.isAuthenticated) {
  final user = authService.currentUser;
  print('Welcome ${user?.name}');
}

// Update tokens
await authService.updateTokens(
  accessToken: newAccessToken,
  refreshToken: newRefreshToken,
);
```

### 4. Storage System (`@/storage`)

Type-safe key-value storage system with a clean abstraction layer.

**Key Components:**
- `AppStorage`: Storage interface abstraction
- `AppStorageImpl`: SharedPreferences implementation

**Features:**
- **Type Safety**: Strongly-typed storage operations
- **Multiple Data Types**: String, bool, int, double, List<String>
- **Async Operations**: Future-based API for all write operations
- **Error Handling**: Graceful error management
- **Testable**: Easy mocking for unit tests

**Example Usage:**
```dart
final storage = get<AppStorage>();

// Store data
await storage.setString('user_preference', 'dark_mode');
await storage.setBool('notifications_enabled', true);

// Retrieve data
final preference = storage.getString('user_preference');
final notificationsEnabled = storage.getBool('notifications_enabled') ?? false;

// Check existence
if (storage.containsKey('user_preference')) {
  // Handle existing data
}
```

### 5. HTTP Client System (`@/http`)

HTTP communication layer with configuration management and logging capabilities.

**Key Components:**
- `IHttpClient`: HTTP client interface
- `HttpClientFactory`: Factory for creating configured HTTP clients
- `HttpConfig`: HTTP client configuration

**Features:**
- **Configurable**: Base URL and logging configuration
- **Factory Pattern**: Centralized client creation
- **Environment Support**: Different configurations per environment
- **Logging**: Debug-mode HTTP request/response logging

## 📁 Project Structure

```
lib/
├── src/
│   ├── core/                          # Core infrastructure
│   │   ├── injection/                 # Dependency injection system
│   │   │   ├── config/               # DI configuration
│   │   │   ├── app_injections.dart   # App-wide dependencies
│   │   │   └── app_injector.dart     # Global injector
│   │   ├── router/                   # Routing system
│   │   │   ├── config/              # Router configuration
│   │   │   └── app_routes.dart      # Route definitions
│   │   ├── services/                # Core services
│   │   │   └── auth/               # Authentication service
│   │   ├── storage/                # Storage abstraction
│   │   ├── http/                   # HTTP client system
│   │   └── constants/              # App constants
│   └── features/                   # Feature modules
│       └── home/                  # Feature example
├── test/                          # Unit tests
│   └── src/
│       └── core/                 # Core system tests
└── main.dart                     # Application entry point
```

## 🧪 Testing Strategy

The project includes comprehensive unit tests for all core systems:

- **Dependency Injection Tests**: Scope management, registration types, lifecycle
- **Router Tests**: Route conversion, navigation, configuration
- **Authentication Tests**: Session management, token handling, error scenarios
- **Storage Tests**: All data types, error handling, persistence
- **Integration Tests**: End-to-end system behavior

**Running Tests:**
```bash
# Run all tests
flutter test

# Run specific test suites
flutter test test/src/core/injection/
flutter test test/src/core/router/
flutter test test/src/core/services/auth/
flutter test test/src/core/storage/
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)

### Setup
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd default_flutter_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

### Development Workflow

1. **Initialize Dependencies**: The app automatically sets up all dependencies on startup
2. **Add Features**: Create new features in the `features/` directory
3. **Register Dependencies**: Add feature dependencies to `AppInjections`
4. **Define Routes**: Add routes to the appropriate route modules
5. **Write Tests**: Maintain test coverage for new functionality

## 🔧 Configuration

### Environment Configuration
Update `lib/src/core/constants/environment_urls_path.dart` for different environments:

```dart
class EnvironmentUrlsPath {
  static const String baseUrl = 'https://api.example.com';
  // Add environment-specific URLs
}
```

### HTTP Client Configuration
Modify HTTP client settings in `AppInjections`:

```dart
HttpClientFactory.createClient(
  config: HttpConfig(baseUrl: EnvironmentUrlsPath.baseUrl),
  enableLogging: kDebugMode,
)
```

## 📚 Best Practices

### Adding New Features
1. Create feature directory under `lib/src/features/`
2. Define feature-specific routes extending `BaseAppRoute`
3. Register feature dependencies in a dedicated injection class
4. Write comprehensive unit tests
5. Update documentation

### Dependency Management
- Always use interfaces for external dependencies
- Register dependencies in appropriate scopes
- Use lazy singletons for expensive objects
- Avoid circular dependencies

### Error Handling
- Implement graceful error recovery
- Log errors appropriately
- Provide user-friendly error messages
- Test error scenarios thoroughly

## 🤝 Contributing

1. **Code Style**: Follow Dart/Flutter conventions
2. **Testing**: Maintain test coverage above 80%
3. **Documentation**: Update README for new features
4. **Architecture**: Follow established patterns
5. **Reviews**: All changes require code review

## 📖 Additional Resources

### Flutter Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)

### Architecture Patterns
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Dependency Injection](https://en.wikipedia.org/wiki/Dependency_injection)
- [Repository Pattern](https://docs.microsoft.com/en-us/dotnet/architecture/microservices/microservice-ddd-cqrs-patterns/infrastructure-persistence-layer-design)

### Testing
- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Unit Testing Best Practices](https://docs.flutter.dev/cookbook/testing/unit/introduction)

---

**Built with ❤️ using Flutter**

# CodeEdex

A Flutter e-commerce application for browsing and purchasing products.

## Flutter Version Used

- **Flutter 3.38.6** (Stable channel)
- **Dart SDK**: ^3.10.7

## Steps to Run the Project

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd codeedex
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Clean build (if needed)**
   ```bash
   flutter clean
   flutter pub get
   ```

4. **Run the application**

   For Android:
   ```bash
   flutter run
   ```

   For iOS:
   ```bash
   flutter run
   ```

   For a specific device:
   ```bash
   flutter devices
   flutter run -d <device-id>
   ```

5. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```

6. **Build iOS (macOS only)**
   ```bash
   flutter build ios --release
   ```

## State Management Used

- **GetX (Get)** - Version 4.6.6
  - Used for state management, dependency injection, and routing
  - Reactive state management with `.obs` observables
  - Controllers for each screen (LoginController, HomeController, ProductDetailController, etc.)
  - Route management via GetX routing system

## Key Dependencies

- `carousel_slider: ^5.1.1` - Product carousel/banner slider
- `flutter_screenutil: ^5.9.0` - Responsive UI design
- `dio: ^5.4.0` - HTTP client for API calls
- `get_storage: ^2.1.1` - Local storage for user data and tokens

## Assumptions Made

1. **API Integration**: The app is configured to work with a backend API for authentication and product data
2. **Font Assets**: The Lufga font family is used throughout the app and is included in the `assets/fonts/Lufga/` directory with weights: Regular (400), Medium (500), SemiBold (600), and Bold (700)
3. **Image Assets**: Product and UI images are stored locally in `assets/image/` directory
4. **Authentication**: Token-based authentication is implemented with local storage
5. **Default Credentials**: Pre-filled email in login screen for testing purposes (`Johndoe@Gmail.Com`)
6. **Product Categories**: Categories are displayed with local image assets
7. **Network Connectivity**: The app assumes active internet connection for API calls

## Known Issues / Limitations

1. **Deprecation Warnings**: Some Flutter SDK deprecation warnings for informational `print` statements in debug code (non-critical)
2. **Error Handling**: Limited offline mode support - app requires internet connection for most features
3. **Image Caching**: Product images from API may require network loading on each view
4. **Cart Functionality**: Cart icon shows static count ("0") in bottom navigation
5. **Profile Section**: Profile and other bottom navigation items are not yet fully implemented
6. **Search Feature**: Search icon in app bar is present but functionality is pending
7. **Favorite Feature**: Favorite icon in app bar is present but functionality is pending
8. **Forgot Password**: "Forgot Password" feature shows "coming soon" message
9. **Sign Up**: "Sign Up" feature shows "coming soon" message
10. **Product Filtering**: Advanced filtering options in product list are limited

## Project Structure

```
lib/
├── main.dart
├── models/              # Data models
├── modules/             # Feature modules
│   ├── auth/           # Authentication (Login)
│   ├── home/           # Home screen
│   ├── product_list/   # Product listing
│   └── product_detail/ # Product details
├── routes/             # App routing configuration
├── services/           # API and storage services
└── widgets/            # Reusable widgets

assets/
├── fonts/Lufga/        # Custom font files
└── image/              # Image assets
```

## API Configuration

The app connects to a backend API. Update the base URL in `lib/services/api_client.dart` if needed.

## Contact

For any questions or issues, please contact the development team.

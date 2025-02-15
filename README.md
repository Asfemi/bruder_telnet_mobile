# Bruder Telnet Mobile App

A Flutter mobile application for Bruder Telnet customer management system.

## 📋 Prerequisites

Before you begin, ensure you have the following installed:
- Flutter (latest stable version)
- Dart SDK
- Android Studio / Xcode (for iOS development)
- Git

## 🚀 Getting Started

### 1. Clone the Repository ()

```bash
git clone https://github.com/Asfemi/bruder_telnet_mobile.git
cd bruder_telnet_mobile
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Setup

1. Create a copy of the environment file:
```bash
cp .env.copy .env
```

2. Configure your environment variables in `.env`:
```env
# API Configuration
NEXT_PUBLIC_API_URL=https://api.newsim.de
API_TOKEN=your_api_token_here

# Supabase Configuration
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Supabase Setup

1. Create a Supabase project at [https://supabase.com](https://supabase.com)
2. Enable Email Authentication in Authentication > Providers
3. Copy your project URL and anon key from Project Settings > API
4. Update the `.env` file with your Supabase credentials

## 🔑 Authentication System

The app implements a two-step authentication process:

1. **External API Validation**
   - Validates user existence in the Bruder Telnet system
   - Uses the `/get_customers` endpoint
   - Requires valid API token

2. **Supabase Authentication**
   - Handles user sessions
   - Manages email/password authentication
   - Provides password reset functionality

### Testing Authentication

1. **Registration Test**
   - Use an email that exists in the Bruder Telnet system
   - Full name must match the customer database
   - Password must be at least 8 characters
   - Phone number in international format (e.g., +33XXXXXXXXX)

2. **Login Test**
   - Use registered email and password
   - Verify successful navigation to main screen
   - Test password reset functionality

3. **API Response Codes**
   ```json
   {
     "status": 1,     // Success
     "status": 600,   // No search fields set
     "status": 401,   // Unauthorized
     "status": 404,   // User not found
   }
   ```

## 🧪 Running Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/auth/auth_repository_test.dart
```

## 📱 Building the App

### Android
```bash
flutter build apk --release
```
The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```
Open Xcode to archive and distribute the app.

## 🔍 Troubleshooting

1. **API Connection Issues**
   - Verify API_TOKEN in .env
   - Check NEXT_PUBLIC_API_URL format
   - Ensure network connectivity

2. **Supabase Authentication Errors**
   - Verify SUPABASE_URL and SUPABASE_ANON_KEY
   - Check if Email Auth is enabled in Supabase
   - Verify email confirmation settings

3. **Build Errors**
   ```bash
   # Clean and rebuild
   flutter clean
   flutter pub get
   flutter run
   ```

## 📚 Documentation

- [API Documentation](https://api.newsim.de/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Flutter Documentation](https://flutter.dev/docs)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

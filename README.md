# FixItNow

## Problem Statement
FixItNow is a home-service booking application designed to solve the problem of finding reliable, skilled, and professional local service providers (like Electricians, Plumbers, and Carpenters) efficiently.

## Objective
The objective is to provide a seamless platform where users can browse service categories, view provider details and ratings, and book services with an estimated cost calculated dynamically.

## Features
- Premium Splash Screen
- Service Category Browsing
- Dynamic Provider Listing based on Category
- Detailed Provider Profiles (Ratings, Reviews, Experience)
- Robust Booking Form with Date, Time, and Address Validation
- Dynamic Cost Estimation
- Booking Confirmation and Summary
- User Bookings Dashboard (Upcoming, Completed, Cancelled)
- Provider Dashboard (to view assigned bookings)

## Technology Stack
- **Flutter**: UI Framework
- **Dart**: Programming Language
- **Riverpod**: State Management (`flutter_riverpod`)
- **Firebase**: Backend Services
- **Cloud Firestore**: Database for storing bookings
- **Material 3**: Design System

## Application Flow
1. **Splash Screen** -> 2. **Home (Categories)** -> 3. **Provider List** -> 4. **Provider Details** -> 5. **Booking Form** -> 6. **Booking Confirmation** -> 7. **My Bookings**

## Project Structure
```
lib/
├── models/         # Data structures (ServiceCategory, ProviderModel, BookingModel)
├── providers/      # Riverpod state managers
├── screens/        # UI Screens
├── widgets/        # Reusable UI components
├── services/       # External API / Database services
├── repositories/   # Data access layer
├── theme/          # Material 3 Theme configurations
├── utils/          # Helper classes like validators
└── main.dart       # Application entry point
```

## Firebase Setup
1. Go to [Firebase Console](https://console.firebase.google.com/).
2. Create a new project named `FixItNow`.
3. Enable **Cloud Firestore** and start in test mode.
4. Run `flutter pub add firebase_core cloud_firestore` (Already done).
5. Use `flutterfire configure` to connect your app to the Firebase project.
6. Run the app.

*(Note: The app is configured with a robust fallback mechanism. If Firebase is not initialized, it will run entirely in-memory using Mock Data, ensuring your presentation/viva works perfectly out of the box!)*

## Running the Project
```bash
flutter pub get
flutter run
```

## Testing
- UI scaling tested with `LayoutBuilder` and `MediaQuery`.
- Form validation tested for correct dates and text lengths.
- State management tested for correct provider filtering upon category change.
- Fallback mock-firestore data tested to ensure seamless booking flows.

## Future Scope
- Online Payments (Stripe/Razorpay Integration)
- Live Provider Tracking via Google Maps
- Real-time Chat
- Push Notifications
- User Authentication (Firebase Auth)

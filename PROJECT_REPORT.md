# FIXITNOW
## Home Service Booking Application

### 1. Problem Understanding
Finding reliable and trustworthy home service professionals such as electricians, plumbers, and carpenters is often a tedious task. Customers struggle with opaque pricing, unverified professionals, and difficult scheduling. FixItNow aims to bridge this gap by providing an intuitive, transparent, and efficient marketplace where users can connect with top-rated service providers in their area.

### 2. Application Design
The application is designed using Material 3 principles, focusing on:
- **Trust + Reliability**: Achieved through a clean, blue-and-white centered theme, rounded cards, and prominent review displays.
- **Navigation**: Uses a Material `NavigationBar` for quick access between Home, Bookings, and Profile.
- **User Journey**:
  - `Splash` -> `Home (Category Selection)` -> `Provider Listing` -> `Provider Detail` -> `Booking Form` -> `Confirmation` -> `Dashboard`

### 3. Implementation
- **Flutter & Dart**: Used for building the cross-platform frontend.
- **Material 3**: Implemented via a centralized `AppTheme` class.
- **Riverpod**: Manages state cleanly. Categories and selected providers are decoupled from UI logic using `StateNotifierProvider` and `Provider`.
- **Firebase & Cloud Firestore**: Used for storing booking records. The architecture includes a `BookingRepository` that handles seamless fallback to mock memory if Firebase is unconfigured, preventing demo crashes.
- **Form Validation**: `Validators` utility class ensures data integrity (e.g., date cannot be in the past, address must be detailed).
- **Dynamic Calculation**: Estimated cost automatically updates based on selected hours and provider's hourly rate.

### 4. Screenshots / Demonstration
*[Insert Splash Screen Screenshot here]*
*[Insert Home Screen Screenshot here]*
*[Insert Provider List Screenshot here]*
*[Insert Booking Form Screenshot here]*
*[Insert Booking Confirmation Screenshot here]*

### 5. Documentation
- **Technologies used**: Flutter, Dart, Riverpod, Firebase Cloud Firestore.
- **Database structure**: A `bookings` collection in Firestore with fields: `id`, `userId`, `providerId`, `serviceType`, `date`, `time`, `address`, `durationHours`, `hourlyRate`, `estimatedCost`, `status`.
- **Riverpod state management**: `flutter_riverpod` provides a predictable state container. It is used to pass the selected category to the provider list screen and filter providers efficiently.
- **Testing performed**: Widget rendering, state update upon category selection, form validation edge cases (empty fields, invalid dates), and responsive grid layout testing.
- **Future scope**: Include real-time GPS tracking, chat support between user and provider, and secure online payment gateways.
- **Conclusion**: FixItNow successfully demonstrates a complete, state-managed, well-architected Flutter application that solves a real-world problem effectively.

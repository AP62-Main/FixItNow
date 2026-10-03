import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';
import '../repositories/booking_repository.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  return BookingRepository();
});

// A provider to fetch bookings for a specific user
final userBookingsProvider = FutureProvider.family<List<BookingModel>, String>((ref, userId) {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getUserBookings(userId);
});

// A provider to fetch bookings for a specific provider
final providerBookingsProvider = FutureProvider.family<List<BookingModel>, String>((ref, providerId) {
  final repository = ref.watch(bookingRepositoryProvider);
  return repository.getProviderBookings(providerId);
});

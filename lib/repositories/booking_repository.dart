import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/booking_model.dart';

// ─── Supabase table name ──────────────────────────────────────────────────────
// Make sure you create a table called 'bookings' in your Supabase project.
// See README for the SQL schema.
const _kBookingsTable = 'bookings';
// ─────────────────────────────────────────────────────────────────────────────

class BookingRepository {
  // In-memory fallback for when Supabase is not configured (demo mode)
  final List<BookingModel> _mockBookings = [];

  static bool _isSupabaseInitialized() {
    try {
      Supabase.instance.client; // throws if not initialized
      return true;
    } catch (_) {
      return false;
    }
  }

  SupabaseClient? get _client =>
      _isSupabaseInitialized() ? Supabase.instance.client : null;

  // ── Create ──────────────────────────────────────────────────────────────────
  Future<void> createBooking(BookingModel booking) async {
    final client = _client;
    if (client != null) {
      try {
        await client.from(_kBookingsTable).insert(booking.toMap());
        return;
      } catch (e) {
        debugPrint('Error saving to Supabase: $e. Falling back to in-memory.');
      }
    }
    // Demo / fallback mode
    _mockBookings.add(booking);
    await Future.delayed(const Duration(seconds: 1));
  }

  // ── Read: bookings for a user ───────────────────────────────────────────────
  Future<List<BookingModel>> getUserBookings(String userId) async {
    final client = _client;
    if (client != null) {
      try {
        final response = await client
            .from(_kBookingsTable)
            .select()
            .eq('userId', userId)
            .order('createdAt', ascending: false);

        return (response as List)
            .map((row) => BookingModel.fromMap(row as Map<String, dynamic>))
            .toList();
      } catch (e) {
        debugPrint('Error reading from Supabase: $e');
      }
    }
    // Fallback / demo
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBookings
        .where((b) => b.userId == userId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // ── Read: bookings for a provider ──────────────────────────────────────────
  Future<List<BookingModel>> getProviderBookings(String providerId) async {
    final client = _client;
    if (client != null) {
      try {
        final response = await client
            .from(_kBookingsTable)
            .select()
            .eq('providerId', providerId)
            .order('createdAt', ascending: false);

        return (response as List)
            .map((row) => BookingModel.fromMap(row as Map<String, dynamic>))
            .toList();
      } catch (e) {
        debugPrint('Error reading from Supabase: $e');
      }
    }
    // Fallback / demo
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBookings
        .where((b) => b.providerId == providerId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}

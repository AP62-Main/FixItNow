import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import '../models/booking_model.dart';

class BookingRepository {
  final FirebaseFirestore? _firestore;
  
  // Use in-memory list if Firebase is not initialized (good for college demo before full setup)
  final List<BookingModel> _mockBookings = [];

  BookingRepository() : _firestore = _isFirebaseInitialized() ? FirebaseFirestore.instance : null;

  static bool _isFirebaseInitialized() {
    try {
      return Firebase.apps.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> createBooking(BookingModel booking) async {
    if (_firestore != null) {
      try {
        await _firestore.collection('bookings').doc(booking.id).set(booking.toMap());
      } catch (e) {
        debugPrint('Error saving to Firestore: $e');
        _mockBookings.add(booking); // Fallback
      }
    } else {
      _mockBookings.add(booking);
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<List<BookingModel>> getUserBookings(String userId) async {
    if (_firestore != null) {
      try {
        final snapshot = await _firestore
            .collection('bookings')
            .where('userId', isEqualTo: userId)
            .orderBy('createdAt', descending: true)
            .get();
            
        return snapshot.docs.map((doc) => BookingModel.fromMap(doc.data(), doc.id)).toList();
      } catch (e) {
        debugPrint('Error reading from Firestore: $e');
      }
    }
    
    // Fallback or mock mode
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBookings.where((b) => b.userId == userId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<List<BookingModel>> getProviderBookings(String providerId) async {
    if (_firestore != null) {
      try {
        final snapshot = await _firestore
            .collection('bookings')
            .where('providerId', isEqualTo: providerId)
            .orderBy('createdAt', descending: true)
            .get();
            
        return snapshot.docs.map((doc) => BookingModel.fromMap(doc.data(), doc.id)).toList();
      } catch (e) {
        debugPrint('Error reading from Firestore: $e');
      }
    }
    
    // Fallback or mock mode
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockBookings.where((b) => b.providerId == providerId).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }
}

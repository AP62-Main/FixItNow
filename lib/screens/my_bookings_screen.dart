import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/booking_model.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/booking_card.dart';

class MyBookingsScreen extends ConsumerStatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  ConsumerState<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends ConsumerState<MyBookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingsAsyncValue = ref.watch(userBookingsProvider('demo-user-123'));

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('My Service Bookings'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppTheme.borderColor)),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.primaryColor,
              indicatorWeight: 2.5,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: AppTheme.textSecondary,
              tabs: const [
                Tab(text: 'Upcoming'),
                Tab(text: 'Completed'),
                Tab(text: 'Cancelled'),
              ],
            ),
          ),
        ),
      ),
      body: bookingsAsyncValue.when(
        data: (bookings) {
          final upcoming = bookings.where((b) => b.status.toLowerCase() == 'confirmed').toList();
          final completed = bookings.where((b) => b.status.toLowerCase() == 'completed').toList();
          final cancelled = bookings.where((b) => b.status.toLowerCase() == 'cancelled').toList();

          return TabBarView(
            controller: _tabController,
            children: [
              _buildBookingList(upcoming, 'No active or upcoming bookings', 'Book an expert specialist to help you today.'),
              _buildBookingList(completed, 'No completed services yet', 'Your completed service history will appear here.'),
              _buildBookingList(cancelled, 'No cancelled requests', 'Any cancelled requests will be archived here.'),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppTheme.primaryColor),
        ),
        error: (error, stack) => Center(
          child: Text('Error loading bookings: $error', style: const TextStyle(color: AppTheme.error)),
        ),
      ),
    );
  }

  Widget _buildBookingList(List<BookingModel> bookings, String emptyTitle, String emptySubtitle) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppTheme.cardColor,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.event_note_outlined, size: 36, color: AppTheme.textDim),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                emptyTitle,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                emptySubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(
          booking: bookings[index],
          onTap: () {
            _showBookingDetailsModal(context, bookings[index]);
          },
        );
      },
    );
  }

  void _showBookingDetailsModal(BuildContext context, BookingModel booking) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppTheme.borderColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    booking.serviceType,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: AppTheme.textPrimary),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGlow,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      booking.status.toUpperCase(),
                      style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Professional: ${booking.providerName}', style: const TextStyle(color: AppTheme.textSecondary)),
              Text('Location: ${booking.address}', style: const TextStyle(color: AppTheme.textSecondary)),
              Text('Estimated: ₹${booking.estimatedCost.toInt()} (${booking.durationHours} hrs)', style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryColor),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

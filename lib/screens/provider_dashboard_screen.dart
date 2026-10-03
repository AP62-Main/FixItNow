import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/booking_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/booking_card.dart';

class ProviderDashboardScreen extends ConsumerWidget {
  const ProviderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Hardcoded provider ID for demo (matches John Electricals)
    const providerId = 'p1';
    final bookingsAsyncValue = ref.watch(providerBookingsProvider(providerId));

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Contractor Hub (John Electricals)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Metrics Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Weekly Overview',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGlow,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'ONLINE & DISPATCHING',
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildMetricItem('₹14,500', 'Gross Earnings', AppTheme.primaryColor),
                      _buildMetricItem('18', 'Completed Jobs', AppTheme.aiCyan),
                      _buildMetricItem('4.9 ★', 'Client Rating', const Color(0xFFFBBF24)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Assigned Booking Requests',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 12),

            bookingsAsyncValue.when(
              data: (bookings) {
                if (bookings.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.borderColor),
                    ),
                    child: const Center(
                      child: Column(
                        children: [
                          Icon(Icons.inbox_outlined, size: 40, color: AppTheme.textDim),
                          SizedBox(height: 12),
                          Text(
                            'No new jobs assigned right now.',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: bookings.map((b) {
                    return BookingCard(
                      booking: b,
                      onTap: () {},
                    );
                  }).toList(),
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(color: AppTheme.primaryColor),
                ),
              ),
              error: (error, stack) => Center(
                child: Text('Error: $error', style: const TextStyle(color: AppTheme.error)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String value, String label, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppTheme.textDim,
            ),
          ),
        ],
      ),
    );
  }
}

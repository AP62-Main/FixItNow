import 'package:flutter/material.dart';
import '../models/provider_model.dart';
import '../theme/app_theme.dart';
import 'rating_widget.dart';

class ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onViewProfile;
  final VoidCallback onBookNow;

  const ProviderCard({
    super.key,
    required this.provider,
    required this.onViewProfile,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section: Avatar, Name, Verified Badge, Rating
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceColor,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.borderSubtle),
                      ),
                      child: Center(
                        child: Text(
                          provider.name.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    if (provider.availableToday)
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.cardColor, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              provider.name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimary,
                                letterSpacing: -0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.verified_rounded,
                            size: 16,
                            color: AppTheme.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceColor,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppTheme.borderColor),
                            ),
                            child: Text(
                              provider.serviceType,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${provider.experienceYears}y exp',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppTheme.textDim,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RatingWidget(rating: provider.rating, reviews: provider.reviews),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Middle section: Key stats row
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.bolt_rounded, size: 16, color: AppTheme.primaryColor),
                      const SizedBox(width: 6),
                      Text(
                        '₹${provider.hourlyRate.toInt()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Text(
                        ' / hr',
                        style: TextStyle(fontSize: 12, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.near_me_outlined, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        '${provider.distance} km',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: provider.availableToday
                          ? AppTheme.primaryGlow
                          : AppTheme.elevatedColor,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: provider.availableToday
                            ? AppTheme.primaryColor.withValues(alpha: 0.3)
                            : AppTheme.borderColor,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: provider.availableToday ? AppTheme.primaryColor : AppTheme.textDim,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          provider.availableToday ? 'Available' : 'Busy',
                          style: TextStyle(
                            color: provider.availableToday ? AppTheme.primaryColor : AppTheme.textDim,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onViewProfile,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('View Profile'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onBookNow,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Book Now'),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

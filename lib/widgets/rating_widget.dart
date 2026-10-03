import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviews;
  final bool compact;
  
  const RatingWidget({
    super.key,
    required this.rating,
    required this.reviews,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 6 : 8, vertical: compact ? 3 : 4),
      decoration: BoxDecoration(
        color: AppTheme.elevatedColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.star_rounded,
            color: Color(0xFFFBBF24),
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppTheme.textPrimary,
              letterSpacing: -0.2,
            ),
          ),
          if (!compact) ...[
            const SizedBox(width: 4),
            Text(
              '($reviews)',
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

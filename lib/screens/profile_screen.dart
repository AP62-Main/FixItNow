import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'provider_dashboard_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Account & Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          children: [
            // User Card with ChatGPT styling
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.5), width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Aditya Sharma',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                SizedBox(width: 6),
                                Icon(Icons.verified, size: 16, color: AppTheme.primaryColor),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'aditya@demo.fixitnow.io',
                              style: TextStyle(color: AppTheme.textDim, fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGlow,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.auto_awesome, size: 12, color: AppTheme.primaryColor),
                                  SizedBox(width: 5),
                                  Text(
                                    'FixItNow Plus Member',
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: AppTheme.borderColor),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildQuickStat('Bookings', '6'),
                      Container(width: 1, height: 28, color: AppTheme.borderColor),
                      _buildQuickStat('Saved Pros', '4'),
                      Container(width: 1, height: 28, color: AppTheme.borderColor),
                      _buildQuickStat('Wallet Credits', '₹450'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Demo Special: Provider Dashboard Switcher
            Container(
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0x1FF59E0B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.engineering_rounded, color: AppTheme.warning, size: 20),
                ),
                title: const Text(
                  'Switch to Provider Hub (Demo)',
                  style: TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textPrimary, fontSize: 15),
                ),
                subtitle: const Text(
                  'View incoming dispatched jobs as a contractor',
                  style: TextStyle(color: AppTheme.textDim, fontSize: 12),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppTheme.textSecondary),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProviderDashboardScreen()),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Menu Section: Preferences
            _buildSectionCard([
              _buildSettingItem(Icons.location_on_outlined, 'Saved Addresses', 'Home, Office, Parents'),
              _buildSettingItem(Icons.credit_card_outlined, 'Payment Methods & UPI', 'Google Pay, Visa ending in 4242'),
              _buildSettingItem(Icons.notifications_none_rounded, 'Push & SMS Alerts', 'Booking confirmations & updates'),
            ]),

            const SizedBox(height: 16),

            // Menu Section: App & Support
            _buildSectionCard([
              _buildSettingItem(Icons.headset_mic_outlined, '24/7 AI & Help Center', 'Instant resolutions'),
              _buildSettingItem(Icons.shield_outlined, 'Privacy Policy & Terms', 'Data protection compliant'),
              _buildSettingItem(Icons.info_outline_rounded, 'About FixItNow AI', 'v2.4.0 • Build 2026.10'),
            ]),

            const SizedBox(height: 24),

            // Sign out
            Container(
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout_rounded, color: AppTheme.error, size: 20),
                title: const Text('Sign Out', style: TextStyle(color: AppTheme.error, fontWeight: FontWeight.w600)),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppTheme.textDim),
        ),
      ],
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary, size: 20),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: AppTheme.textDim),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.textDim),
      onTap: () {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/provider_model.dart';
import '../providers/category_provider.dart';
import '../providers/provider_list_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/provider_card.dart';
import 'provider_details_screen.dart';
import 'booking_screen.dart';

class ProviderListScreen extends ConsumerStatefulWidget {
  const ProviderListScreen({super.key});

  @override
  ConsumerState<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends ConsumerState<ProviderListScreen> {
  String _filterType = 'all'; // all, available, rating, price
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final rawProviders = ref.watch(providerListProvider);

    // Apply filtering and search
    List<ProviderModel> filteredProviders = rawProviders.where((p) {
      if (_filterType == 'available' && !p.availableToday) return false;
      if (_filterType == 'rating' && p.rating < 4.8) return false;
      if (_filterType == 'price' && p.hourlyRate > 600) return false;
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return p.name.toLowerCase().contains(q) ||
               p.serviceType.toLowerCase().contains(q) ||
               p.about.toLowerCase().contains(q);
      }
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          selectedCategory != null ? '${selectedCategory.name} Specialists' : 'All Professionals',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            ref.read(selectedCategoryProvider.notifier).clearCategory();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header container
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceColor,
              border: Border(
                bottom: BorderSide(color: AppTheme.borderColor),
              ),
            ),
            child: Column(
              children: [
                // Quick Search Bar
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.cardColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.borderColor),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 18, color: AppTheme.textSecondary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          style: const TextStyle(fontSize: 13, color: AppTheme.textPrimary),
                          decoration: const InputDecoration(
                            hintText: 'Filter by name or keywords...',
                            hintStyle: TextStyle(color: AppTheme.textDim, fontSize: 13),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          onChanged: (v) => setState(() => _searchQuery = v),
                        ),
                      ),
                      if (_searchQuery.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          child: const Icon(Icons.close, size: 16, color: AppTheme.textSecondary),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Filter Pill Chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('All Pros', 'all'),
                      const SizedBox(width: 8),
                      _buildFilterChip('⚡ Available Today', 'available'),
                      const SizedBox(width: 8),
                      _buildFilterChip('⭐ Top Rated (4.8+)', 'rating'),
                      const SizedBox(width: 8),
                      _buildFilterChip('💰 Under ₹600/hr', 'price'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Provider Count Sub-header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${filteredProviders.length} verified pros matched',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 14, color: AppTheme.primaryColor),
                    SizedBox(width: 4),
                    Text(
                      'Background Verified',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Providers List
          Expanded(
            child: filteredProviders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: AppTheme.cardColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.person_search_outlined, size: 48, color: AppTheme.textDim),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No professionals matched your criteria',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Try clearing active filters to see all specialists.',
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _filterType = 'all';
                            });
                          },
                          child: const Text('Reset All Filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 24),
                    itemCount: filteredProviders.length,
                    itemBuilder: (context, index) {
                      final provider = filteredProviders[index];
                      return ProviderCard(
                        provider: provider,
                        onViewProfile: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProviderDetailsScreen(provider: provider),
                            ),
                          );
                        },
                        onBookNow: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(provider: provider),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String type) {
    final isSelected = _filterType == type;
    return InkWell(
      onTap: () => setState(() => _filterType = type),
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGlow : AppTheme.cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}

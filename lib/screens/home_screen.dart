import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_category.dart';
import '../providers/category_provider.dart';
import '../providers/provider_list_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/service_category_card.dart';
import '../widgets/provider_card.dart';
import 'provider_list_screen.dart';
import 'provider_details_screen.dart';
import 'booking_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _quickPrompts = [
    {'title': 'Power Outage', 'icon': Icons.bolt_rounded, 'categoryId': 'c1'},
    {'title': 'Pipe Leakage', 'icon': Icons.water_drop_rounded, 'categoryId': 'c2'},
    {'title': 'AC Not Cooling', 'icon': Icons.ac_unit_rounded, 'categoryId': 'c3'},
    {'title': 'Furniture Repair', 'icon': Icons.chair_rounded, 'categoryId': 'c4'},
    {'title': 'Deep Cleaning', 'icon': Icons.cleaning_services_rounded, 'categoryId': 'c5'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onPromptTap(String categoryId, List<ServiceCategory> categories) {
    final matched = categories.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => categories.first,
    );
    ref.read(selectedCategoryProvider.notifier).selectCategory(matched);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProviderListScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesProvider);
    final allProviders = ref.watch(allProvidersProvider);

    final filteredCategories = _searchQuery.isEmpty
        ? categories
        : categories.where((c) {
            return c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                   c.description.toLowerCase().contains(_searchQuery.toLowerCase());
          }).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppTheme.cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 18,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            RichText(
              text: const TextSpan(
                text: 'FixIt',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                  letterSpacing: -0.3,
                ),
                children: [
                  TextSpan(
                    text: 'Now',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.primaryGlow,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'AI 4.0',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppTheme.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  '12 Pros Online',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero ChatGPT Prompt Header
              const SizedBox(height: 12),
              Text(
                'What service do you need today?',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'AI-matched licensed professionals at your doorstep in under 30 minutes.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // ChatGPT Style Message/Search Prompt Bar
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _searchQuery.isNotEmpty ? AppTheme.primaryColor : AppTheme.borderColor,
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: AppTheme.primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 15,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Search electrician, plumbing, AC repair...',
                          hintStyle: TextStyle(
                            color: AppTheme.textDim,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onChanged: (val) {
                          setState(() => _searchQuery = val);
                        },
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      IconButton(
                        icon: const Icon(Icons.close, size: 18, color: AppTheme.textSecondary),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _searchQuery.isNotEmpty ? AppTheme.primaryColor : AppTheme.elevatedColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_upward_rounded,
                          size: 18,
                          color: _searchQuery.isNotEmpty ? Colors.white : AppTheme.textDim,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ChatGPT Quick Prompt Pills
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _quickPrompts.length,
                  separatorBuilder: (context, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = _quickPrompts[index];
                    return InkWell(
                      onTap: () => _onPromptTap(item['categoryId'] as String, categories),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTheme.borderColor),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              size: 13,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              item['title'] as String,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 28),

              // Section Header: Categories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Service Categories',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.elevatedColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${filteredCategories.length}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_searchQuery.isNotEmpty)
                    TextButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                      child: const Text('Reset', style: TextStyle(color: AppTheme.primaryColor)),
                    ),
                ],
              ),
              const SizedBox(height: 14),

              // Categories Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth > 720 ? 4 : 2;
                  double childAspectRatio = constraints.maxWidth > 720 ? 1.05 : 0.95;
                  
                  if (filteredCategories.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: AppTheme.cardColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: const Center(
                        child: Text(
                          'No services found matching your prompt.',
                          style: TextStyle(color: AppTheme.textSecondary),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: childAspectRatio,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredCategories.length,
                    itemBuilder: (context, index) {
                      final category = filteredCategories[index];
                      return ServiceCategoryCard(
                        category: category,
                        onTap: () {
                          ref.read(selectedCategoryProvider.notifier).selectCategory(category);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProviderListScreen(),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 32),

              // Section Header: Top Rated Specialists Available
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Top Specialists',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(selectedCategoryProvider.notifier).clearCategory();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProviderListScreen(),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('View All', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w600)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward_rounded, size: 14, color: AppTheme.primaryColor),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Featured Providers List
              ...allProviders.take(3).map((provider) {
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
              }),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

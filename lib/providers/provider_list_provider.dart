import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/provider_model.dart';
import 'category_provider.dart';

final allProvidersProvider = Provider<List<ProviderModel>>((ref) {
  return [
    // Electricians
    const ProviderModel(id: 'p1', name: 'John Electricals', categoryId: 'c1', serviceType: 'Electrician', rating: 4.8, reviews: 124, hourlyRate: 650, distance: 2.4, availableToday: true, about: 'Expert electrician with 10 years of experience in residential and commercial wiring.', experienceYears: 10),
    const ProviderModel(id: 'p2', name: 'SparkPro Services', categoryId: 'c1', serviceType: 'Electrician', rating: 4.6, reviews: 89, hourlyRate: 600, distance: 5.1, availableToday: false, about: 'Quick and reliable electrical repairs and installations.', experienceYears: 7),
    const ProviderModel(id: 'p3', name: 'PowerFix Experts', categoryId: 'c1', serviceType: 'Electrician', rating: 4.9, reviews: 210, hourlyRate: 750, distance: 1.2, availableToday: true, about: 'Premium electrical services for your modern home.', experienceYears: 12),
    
    // Plumbers
    const ProviderModel(id: 'p4', name: 'AquaFix Plumbing', categoryId: 'c2', serviceType: 'Plumber', rating: 4.7, reviews: 156, hourlyRate: 500, distance: 3.0, availableToday: true, about: 'All kinds of plumbing repairs, leaks, and pipe installations.', experienceYears: 8),
    const ProviderModel(id: 'p5', name: 'PipeCare Services', categoryId: 'c2', serviceType: 'Plumber', rating: 4.5, reviews: 75, hourlyRate: 450, distance: 4.5, availableToday: true, about: 'Affordable and professional plumbing.', experienceYears: 5),
    const ProviderModel(id: 'p6', name: 'RapidFlow Plumbers', categoryId: 'c2', serviceType: 'Plumber', rating: 4.8, reviews: 92, hourlyRate: 550, distance: 1.8, availableToday: false, about: 'Emergency plumbing services available 24/7.', experienceYears: 9),
    
    // AC Repair
    const ProviderModel(id: 'p7', name: 'CoolCare Services', categoryId: 'c3', serviceType: 'AC Repair', rating: 4.9, reviews: 320, hourlyRate: 800, distance: 2.1, availableToday: true, about: 'Expert in all brands of AC servicing and repair.', experienceYears: 15),
    const ProviderModel(id: 'p8', name: 'ArcticFix', categoryId: 'c3', serviceType: 'AC Repair', rating: 4.4, reviews: 45, hourlyRate: 700, distance: 6.2, availableToday: true, about: 'Quick AC fixes and gas filling.', experienceYears: 4),
    
    // Carpenters
    const ProviderModel(id: 'p9', name: 'WoodCraft Experts', categoryId: 'c4', serviceType: 'Carpenter', rating: 4.8, reviews: 110, hourlyRate: 550, distance: 3.5, availableToday: true, about: 'Custom furniture, door fittings and modular kitchen woodwork.', experienceYears: 20),
    const ProviderModel(id: 'p10', name: 'TimberFix', categoryId: 'c4', serviceType: 'Carpenter', rating: 4.6, reviews: 68, hourlyRate: 500, distance: 4.0, availableToday: false, about: 'General carpentry repairs and fittings.', experienceYears: 6),
    
    // Cleaning
    const ProviderModel(id: 'p11', name: 'CleanPro Services', categoryId: 'c5', serviceType: 'Cleaning', rating: 4.7, reviews: 250, hourlyRate: 400, distance: 1.5, availableToday: true, about: 'Deep home cleaning, bathroom cleaning, and sofa dry cleaning.', experienceYears: 5),
    
    // Painter
    const ProviderModel(id: 'p12', name: 'ColorCraft', categoryId: 'c6', serviceType: 'Painter', rating: 4.8, reviews: 140, hourlyRate: 600, distance: 2.8, availableToday: true, about: 'Premium wall painting, texture painting, and waterproofing.', experienceYears: 12),
  ];
});

final providerListProvider = Provider<List<ProviderModel>>((ref) {
  final allProviders = ref.watch(allProvidersProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  
  if (selectedCategory == null) {
    return allProviders;
  }
  
  return allProviders.where((p) => p.categoryId == selectedCategory.id).toList();
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/service_category.dart';

final categoriesProvider = Provider<List<ServiceCategory>>((ref) {
  return [
    const ServiceCategory(id: 'c1', name: 'Electrician', description: 'Wiring, fixtures & appliances', icon: Icons.electrical_services, color: Colors.orange),
    const ServiceCategory(id: 'c2', name: 'Plumber', description: 'Pipes, leaks & installations', icon: Icons.plumbing, color: Colors.blue),
    const ServiceCategory(id: 'c3', name: 'AC Repair', description: 'Service, repair & installation', icon: Icons.ac_unit, color: Colors.lightBlue),
    const ServiceCategory(id: 'c4', name: 'Carpenter', description: 'Furniture, doors & woodwork', icon: Icons.handyman, color: Colors.brown),
    const ServiceCategory(id: 'c5', name: 'Cleaning', description: 'Deep cleaning & sanitization', icon: Icons.cleaning_services, color: Colors.teal),
    const ServiceCategory(id: 'c6', name: 'Painter', description: 'Interior & exterior painting', icon: Icons.format_paint, color: Colors.purple),
    const ServiceCategory(id: 'c7', name: 'Appliance Repair', description: 'TV, Fridge, Washing Machine', icon: Icons.tv, color: Colors.red),
    const ServiceCategory(id: 'c8', name: 'General Handyman', description: 'Odd jobs & quick fixes', icon: Icons.build, color: Colors.blueGrey),
  ];
});

class SelectedCategoryNotifier extends Notifier<ServiceCategory?> {
  @override
  ServiceCategory? build() {
    return null;
  }

  void selectCategory(ServiceCategory category) {
    state = category;
  }

  void clearCategory() {
    state = null;
  }
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, ServiceCategory?>(() {
  return SelectedCategoryNotifier();
});

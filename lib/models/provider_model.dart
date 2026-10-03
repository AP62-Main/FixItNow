class ProviderModel {
  final String id;
  final String name;
  final String categoryId;
  final String serviceType;
  final double rating;
  final int reviews;
  final double hourlyRate;
  final double distance;
  final bool availableToday;
  final String about;
  final int experienceYears;

  const ProviderModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.serviceType,
    required this.rating,
    required this.reviews,
    required this.hourlyRate,
    required this.distance,
    required this.availableToday,
    required this.about,
    required this.experienceYears,
  });
}

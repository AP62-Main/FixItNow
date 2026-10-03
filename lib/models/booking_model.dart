class BookingModel {
  final String id;
  final String userId;
  final String providerId;
  final String providerName;
  final String serviceType;
  final DateTime date;
  final String time;
  final String address;
  final int durationHours;
  final double hourlyRate;
  final double estimatedCost;
  final String additionalDetails;
  final String status; // 'confirmed', 'completed', 'cancelled'
  final DateTime createdAt;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.providerName,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.address,
    required this.durationHours,
    required this.hourlyRate,
    required this.estimatedCost,
    this.additionalDetails = '',
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'providerId': providerId,
      'providerName': providerName,
      'serviceType': serviceType,
      'date': date.toIso8601String(),
      'time': time,
      'address': address,
      'durationHours': durationHours,
      'hourlyRate': hourlyRate,
      'estimatedCost': estimatedCost,
      'additionalDetails': additionalDetails,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      providerId: map['providerId'] ?? '',
      providerName: map['providerName'] ?? '',
      serviceType: map['serviceType'] ?? '',
      date: DateTime.parse(map['date']),
      time: map['time'] ?? '',
      address: map['address'] ?? '',
      durationHours: map['durationHours']?.toInt() ?? 1,
      hourlyRate: map['hourlyRate']?.toDouble() ?? 0.0,
      estimatedCost: map['estimatedCost']?.toDouble() ?? 0.0,
      additionalDetails: map['additionalDetails'] ?? '',
      status: map['status'] ?? 'confirmed',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

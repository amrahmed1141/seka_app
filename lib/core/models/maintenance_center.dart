class MaintenanceCenter {
  final String id;
  final String name;
  final String phone;
  final String? locationUrl;
  final String area;
  final List<String> services;
  final double? rating;
  final String? imageUrl; // Added

  MaintenanceCenter({
    required this.id,
    required this.name,
    required this.phone,
    this.locationUrl,
    required this.area,
    required this.services,
    this.rating,
    this.imageUrl, // Added
  });

  factory MaintenanceCenter.fromJson(Map<String, dynamic> json) {
    return MaintenanceCenter(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      locationUrl: json['locationUrl'] as String?,
      area: json['area'] as String,
      services: List<String>.from(json['services'] as List),
      rating: json['rating'] as double?,
      imageUrl: json['imageUrl'] as String?, // Added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'locationUrl': locationUrl,
      'area': area,
      'services': services,
      'rating': rating,
      'imageUrl': imageUrl, // Added
    };
  }
}

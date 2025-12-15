class DrivingSchool {
  final String id;
  final String name;
  final String phone;
  final String area;
  final double? rating;
  final String? description;
  final String? imageUrl; // Added

  DrivingSchool({
    required this.id,
    required this.name,
    required this.phone,
    required this.area,
    this.rating,
    this.description,
    this.imageUrl, // Added
  });

  factory DrivingSchool.fromJson(Map<String, dynamic> json) {
    return DrivingSchool(
      id: json['id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      area: json['area'] as String,
      rating: json['rating'] as double?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?, // Added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'area': area,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl, // Added
    };
  }
}


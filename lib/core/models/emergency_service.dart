enum EmergencyServiceType {
  towing, // ونش
  fuel, // بنزين
  battery, // كهرباء
  tire, // كوتشيات
  mobile, // خدمة متنقلة
  general, // خدمة عامة
}

class EmergencyService {
  final String id;
  final String name;
  final List<String> phones;
  final EmergencyServiceType type;
  final String? area;
  final bool hasWhatsApp;
  final String? description;
  final String? imageUrl; // Added

  EmergencyService({
    required this.id,
    required this.name,
    required this.phones,
    required this.type,
    this.area,
    this.hasWhatsApp = false,
    this.description,
    this.imageUrl, // Added
  });

  factory EmergencyService.fromJson(Map<String, dynamic> json) {
    return EmergencyService(
      id: json['id'] as String,
      name: json['name'] as String,
      phones: List<String>.from(json['phones'] as List),
      type: EmergencyServiceType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      area: json['area'] as String?,
      hasWhatsApp: json['hasWhatsApp'] as bool? ?? false,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?, // Added
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phones': phones,
      'type': type.name,
      'area': area,
      'hasWhatsApp': hasWhatsApp,
      'description': description,
      'imageUrl': imageUrl, // Added
    };
  }
}
 
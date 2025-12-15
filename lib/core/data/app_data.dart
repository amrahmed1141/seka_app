import '../models/maintenance_center.dart';
import '../models/driving_school.dart';
import '../models/emergency_service.dart';

class AppData {
  // Maintenance Centers
  static final List<MaintenanceCenter> maintenanceCenters = [
    MaintenanceCenter(
      id: 'mc_001',
      name: 'مركز اوتو كيان',
      phone: '01010020676',
      locationUrl: 'https://maps.app.goo.gl/q8qbprrzFAAZK7jCA',
      area: 'القاهرة',
      services: ['صيانة دورية', 'إصلاح أعطال', 'قطع غيار'],
      imageUrl: 'assets/images/maintenance/m3.jpeg',
    ),
    MaintenanceCenter(
      id: 'mc_002',
      name: 'مركز جريدة وقطع غيار',
      phone: '01119635810',
      locationUrl: 'https://maps.app.goo.gl/vBmZHsJZytzTJbaZ9',
      area: 'القاهرة',
      services: ['قطع غيار', 'صيانة'],
      imageUrl: 'assets/images/maintenance/m6.jpeg',
    ),
    MaintenanceCenter(
      id: 'mc_003',
      name: 'مركز مينا تيربو',
      phone: '01279628882',
      locationUrl: 'https://maps.app.goo.gl/z4mBywqAwp7EZZaF6',
      area: 'القاهرة',
      services: ['صيانة تيربو', 'قطع غيار'],
      imageUrl: 'assets/images/maintenance/m5.jpeg',
    ),
    MaintenanceCenter(
      id: 'mc_004',
      name: 'Jeep Market',
      phone: '01225555120',
      locationUrl: 'https://maps.app.goo.gl/HQrMor66bz2TcLEz6',
      area: 'القاهرة',
      services: ['صيانة جيب', 'قطع غيار'],
      imageUrl: 'assets/images/maintenance/m4.jpeg',
    ),
    MaintenanceCenter(
      id: 'mc_005',
      name: 'مركز لطيف سيرفس',
      phone: '01201050605',
      locationUrl: 'https://maps.app.goo.gl/MyeGfo92CfJ9GETX8',
      area: 'القاهرة',
      services: ['صيانة عامة', 'إصلاح'],
      imageUrl: 'assets/images/maintenance/m2.jpeg',
    ),
    MaintenanceCenter(
      id: 'mc_006',
      name: 'DRIVEN AUTO SERVICE',
      phone: '01201380001',
      locationUrl: 'https://maps.app.goo.gl/Srws4STArbXq2Z9e7',
      area: 'القاهرة',
      services: ['صيانة متنقلة', 'طوارئ'],
      imageUrl: 'assets/images/maintenance/m1.jpeg',
    ),
  ];

  // Driving Schools
  static final List<DrivingSchool> drivingSchools = [
    DrivingSchool(
      id: 'ds_001',
      name: 'سليم كار لتعليم القيادة',
      phone: '01127839000',
      area: 'شبرا',
      imageUrl: 'assets/images/learning/d1.jpeg',
    ),
    DrivingSchool(
      id: 'ds_002',
      name: 'شهد كار لتعليم القيادة',
      phone: '01226141779',
      area: 'حدائق القبة',
      imageUrl: 'assets/images/learning/d5.jpeg',
    ),
    DrivingSchool(
      id: 'ds_003',
      name: 'فريدة كار لتعليم القيادة',
      phone: '01020303360',
      area: 'مدينة نصر',
      imageUrl: 'assets/images/learning/d4.jpeg',
    ),
    DrivingSchool(
      id: 'ds_004',
      name: 'العبور كار لتعليم القيادة',
      phone: '01011429994',
      area: 'العبور',
      imageUrl: 'assets/images/learning/d7.jpeg',
    ),
    DrivingSchool(
      id: 'ds_005',
      name: 'كريزي كار لتعليم القيادة',
      phone: '01007556410',
      area: 'شيراتون',
      imageUrl: 'assets/images/learning/d2.jpeg',
    ),
    DrivingSchool(
      id: 'ds_006',
      name: 'نيو كايرو كار لتعليم القيادة',
      phone: '01032339775',
      area: 'التجمع',
      imageUrl: 'assets/images/learning/d3.jpeg',
    ),
  ];

  // Emergency Services
  static final List<EmergencyService> emergencyServices = [
    EmergencyService(
      id: 'es_001',
      name: 'ونش نقل وإنقاذ سيارات',
      phones: ['01030700959', '01015601547', '01273739000', '01273738000'],
      type: EmergencyServiceType.towing,
      imageUrl: 'assets/images/emergency/e3.jpeg',
    ),
    EmergencyService(
      id: 'es_002',
      name: 'ونش متخصص - مصر الجديدة',
      phones: ['01013181661', '01222157771', '01222157772'],
      type: EmergencyServiceType.towing,
      area: 'مصر الجديدة والأماكن الحيوية',
      imageUrl: 'assets/images/emergency/e1.jpeg',
    ),
    EmergencyService(
      id: 'es_003',
      name: 'خدمات نقل',
      phones: ['01121171612'],
      type: EmergencyServiceType.towing,
      imageUrl: 'assets/images/emergency/e2.jpeg',
    ),
    EmergencyService(
      id: 'es_004',
      name: 'خدمات نقل وإنقاذ',
      phones: ['01017439322', '01094833093', '01144849927'],
      type: EmergencyServiceType.towing,
      hasWhatsApp: true,
      imageUrl: 'assets/images/emergency/e3.jpeg',
    ),
    EmergencyService(
      id: 'es_005',
      name: 'خدمة إنقاذ عامة',
      phones: ['01025940878', '01157778900'],
      type: EmergencyServiceType.general,
      imageUrl: 'assets/images/emergency/e1.jpeg',
    ),
    EmergencyService(
      id: 'es_006',
      name: 'Koraik - خدمة متنقلة',
      phones: ['01025407646', '01200560982'],
      type: EmergencyServiceType.mobile,
      description: 'خدمات متنقلة وصيانة سريعة',
      imageUrl: 'assets/images/emergency/e2.jpeg',
    ),
    EmergencyService(
      id: 'es_007',
      name: 'El Rehany Service Center',
      phones: ['01501426677', '01501436677'],
      type: EmergencyServiceType.mobile,
      description: 'خدمات متنقلة وصيانة سريعة',
      imageUrl: 'assets/images/emergency/e3.jpeg',
    ),
    EmergencyService(
      id: 'es_008',
      name: 'Modern Services Group',
      phones: ['01001249765', '01211492280', '01155722142'],
      type: EmergencyServiceType.mobile,
      description: 'خدمات متنقلة وصيانة سريعة',
      imageUrl: 'assets/images/emergency/e1.jpeg',
    ),
    EmergencyService(
      id: 'es_009',
      name: 'MBR Car Service',
      phones: ['01018200182'],
      type: EmergencyServiceType.mobile,
      description: 'خدمة سيارة متنقلة',
      imageUrl: 'assets/images/emergency/e2.jpeg',
    ),
    EmergencyService(
      id: 'es_010',
      name: 'مركز الألماني',
      phones: ['01224727111', '01110300121'],
      type: EmergencyServiceType.mobile,
      description: 'مركز صيانة يوفر طوارئ على الطريق',
      imageUrl: 'assets/images/emergency/e3.jpeg',
    ),
  ];
}


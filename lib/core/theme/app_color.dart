import 'package:flutter/material.dart';

/// App color palette for Seka application
/// Based on the official brand guidelines
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  /// Primary orange for main buttons, brand logo, attractive headlines
  /// استخدام: الأزرار الرئيسية، شعار العلامة التجارية، العناوين الجذابة
  static const Color primaryOrange = Color(0xFFFF751F);

  /// Primary dark blue for reliability
  /// استخدام: الخلفيات الداكنة، النصوص الطويلة، الأيقونات الاحترافية، الحدود
  static const Color primaryBlue = Color(0xFF004AAD);

  // Accent Colors
  /// Service blue for links and interactive elements
  /// استخدام: الروابط، العناصر التفاعلية الثانوية، الحالات النشطة
  static const Color accentBlue = Color(0xFF4C72B0);

  // Background & Text Colors
  /// Light grey for app/website background and section dividers
  /// استخدام: خلفية التطبيق أو الموقع، الفواصل بين الأقسام
  static const Color lightGrey = Color(0xFFF5F5F5);

  /// Soft black for main reading text to ensure clarity
  /// استخدام: نصوص القراءة الرئيسية لضمان الوضوح
  static const Color darkText = Color(0xFF333333);

  // Status Colors
  /// Success green for positive confirmation messages
  /// استخدام: رسائل التأكيد الإيجابية (مثل "تمت الخدمة بنجاح")
  static const Color successGreen = Color(0xFF4CAF50);

  /// Warning yellow for alerts that don't require immediate action
  /// استخدام: التنبيهات التي لا تتطلب إجراءً فورياً
  static const Color warningYellow = Color(0xFFFFC107);

  /// Error red for critical alerts
  static const Color errorRed = Color(0xFFF44336);

  // Additional UI Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  /// Light grey for borders and dividers
  static Color grey300 = Colors.grey[300]!;
  
  /// Medium grey for secondary text
  static Color grey600 = Colors.grey[600]!;
}

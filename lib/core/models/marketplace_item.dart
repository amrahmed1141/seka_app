class MarketplaceItem {
  final String id;
  final String title; // اسم المنتج
  final String brand; // الماركة
  final String area; // المنطقة
  final double price; // السعر
  final String phone; // رقم للتواصل
  final String? whatsapp; // رقم واتساب (اختياري)
  final String? description; // وصف (اختياري)
  final List<String> tags; // كلمات مثل: "إطارات" - "زيوت"...
  final String? imageUrl; // صورة المنتج
  final String? logoUrl; // لوجو البائع/المحل (اختياري)
  final String? locationUrl; // رابط خريطة (اختياري)

  const MarketplaceItem({
    required this.id,
    required this.title,
    required this.brand,
    required this.area,
    required this.price,
    required this.phone,
    this.whatsapp,
    this.description,
    required this.tags,
    this.imageUrl,
    this.logoUrl,
    this.locationUrl,
  });
}

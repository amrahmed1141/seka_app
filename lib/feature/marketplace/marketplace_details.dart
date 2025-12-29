import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/models/marketplace_item.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketplaceItemDetailsPage extends StatefulWidget {
  final MarketplaceItem item;
  const MarketplaceItemDetailsPage({super.key, required this.item});

  @override
  State<MarketplaceItemDetailsPage> createState() => _MarketplaceItemDetailsPageState();
}

class _MarketplaceItemDetailsPageState extends State<MarketplaceItemDetailsPage> {
  late TapGestureRecognizer gestureRecognizer;
  bool showMore = false;

  @override
  void initState() {
    gestureRecognizer = TapGestureRecognizer()
      ..onTap = () => setState(() => showMore = !showMore);
    super.initState();
  }

  @override
  void dispose() {
    gestureRecognizer.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح الرابط')),
      );
    }
  }

  Future<void> _callPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر إجراء المكالمة')),
      );
    }
  }

  Future<void> _openWhatsApp(String phone) async {
    // رقم مصري: لو عندك +20 حطه في الداتا، أو سيبه زي ما هو
    final cleaned = phone.replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$cleaned');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح واتساب')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    final description = (item.description?.trim().isNotEmpty ?? false)
        ? item.description!
        : "لا يوجد وصف لهذا المنتج حالياً.";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.primaryOrange.withOpacity(0.9)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: () => _callPhone(item.phone),
                    icon: const Icon(Iconsax.call, size: 18),
                    label: Text(
                      item.phone,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: item.whatsapp != null
                        ? () => _openWhatsApp(item.whatsapp!)
                        : () => _callPhone(item.phone),
                    icon: const Icon(Iconsax.message, size: 18),
                    label: Text(
                      item.whatsapp != null ? "واتساب" : "تواصل",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "التفاصيل",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: AppColors.primaryBlue,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_right_3, color: AppColors.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
          children: [
            Hero(
              tag: item.imageUrl ?? 'mp_${item.id}_placeholder',
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(item.imageUrl ?? 'assets/images/placeholder.png'),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${item.price.toStringAsFixed(0)} مليون',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryBlue,
                    fontSize: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Iconsax.tag, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.brand,
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    item.area,
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Text("التصنيفات", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.tags.map((t) {
                return Chip(
                  label: Text(t),
                  backgroundColor: AppColors.lightGrey,
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("الموقع", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                if (item.locationUrl != null)
                  TextButton(
                    onPressed: () => _openUrl(item.locationUrl!),
                    child: const Text("فتح الخريطة"),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/maps.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Center(
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: Icon(Iconsax.location, color: AppColors.primaryBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text("الوصف", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
            const SizedBox(height: 6),

            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
                children: [
                  TextSpan(
                    text: showMore
                        ? description
                        : description.length > 90
                            ? '${description.substring(0, 90)}...'
                            : description,
                  ),
                  TextSpan(
                    recognizer: gestureRecognizer,
                    text: description.length > 90 ? (showMore ? " أقل" : " المزيد") : "",
                    style: const TextStyle(color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

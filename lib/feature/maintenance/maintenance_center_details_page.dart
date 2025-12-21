import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/models/maintenance_center.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class MaintenanceCenterDetailsPage extends StatefulWidget {
  final MaintenanceCenter center;
  const MaintenanceCenterDetailsPage({super.key, required this.center});

  @override
  State<MaintenanceCenterDetailsPage> createState() =>
      _MaintenanceCenterDetailsPageState();
}

class _MaintenanceCenterDetailsPageState
    extends State<MaintenanceCenterDetailsPage> {
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

  @override
  Widget build(BuildContext context) {
    final center = widget.center;

    final description = (center.services.isNotEmpty)
        ? "الخدمات المتاحة: ${center.services.join('، ')}"
        : "لا توجد خدمات مسجلة لهذا المركز حالياً.";

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        // ✅ Bottom Buttons
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
                      side: BorderSide(
                        color: AppColors.primaryOrange.withOpacity(0.9),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _callPhone(center.phone),
                    icon: const Icon(Iconsax.call, size: 18),
                    label: Text(
                      center.phone,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      // TODO: replace with booking screen if exists
                      _callPhone(center.phone);
                    },
                    child: const Text(
                      "حجز",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            icon:
                const Icon(Iconsax.arrow_right_3, color: AppColors.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.fromLTRB(
              18, 18, 18, 120), // 👈 space for buttons
          children: [
            Hero(
              tag: center.imageUrl ?? 'assets/images/placeholder.png',
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        center.imageUrl ?? 'assets/images/placeholder.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Text(
              center.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.location_on, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    center.area,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "الموقع",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                TextButton(
                  onPressed: () => _openUrl(center.locationUrl!),
                  child: const Text("فتح الخريطة"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: center.locationUrl != null
                  ? () => _openUrl(center.locationUrl!)
                  : null,
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.black12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Stack(
                    children: [
                      // ✅ Map Image
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/maps.png',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // ✅ Center pin
                      const Center(
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Iconsax.location,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),

                      // ✅ Bottom info bar (like your screenshot)
                      Positioned(
                        left: 10,
                        right: 10,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Iconsax.location,
                                size: 18,
                                color: AppColors.primaryBlue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  center.area,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Iconsax.arrow_left_2,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "الخدمات",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: center.services.map((s) {
                return Chip(
                  label: Text(s),
                  backgroundColor: AppColors.lightGrey,
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            const Text(
              "الوصف",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),

            const SizedBox(height: 6),

            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.black54,
                ),
                children: [
                  TextSpan(
                    text: showMore
                        ? description
                        : description.length > 80
                            ? '${description.substring(0, 80)}...'
                            : description,
                  ),
                  TextSpan(
                    recognizer: gestureRecognizer,
                    text: description.length > 80
                        ? (showMore ? " أقل" : " المزيد")
                        : "",
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

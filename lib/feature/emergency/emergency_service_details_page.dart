import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/models/emergency_service.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyServiceDetailsPage extends StatelessWidget {
  final EmergencyService service;
  const EmergencyServiceDetailsPage({super.key, required this.service});

  Future<void> _callPhone(BuildContext context, String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر إجراء المكالمة')),
      );
    }
  }

  Future<void> _openWhatsApp(BuildContext context, String phone) async {
    // ✅ WhatsApp deep link
    final normalized = phone.replaceAll(' ', '');
    final uri = Uri.parse('https://wa.me/$normalized');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تعذر فتح واتساب')),
      );
    }
  }

  String _typeLabel(EmergencyServiceType type) {
    switch (type) {
      case EmergencyServiceType.towing:
        return 'ونش';
      case EmergencyServiceType.fuel:
        return 'بنزين';
      case EmergencyServiceType.battery:
        return 'كهرباء';
      case EmergencyServiceType.tire:
        return 'كوتشيات';
      case EmergencyServiceType.mobile:
        return 'خدمة متنقلة';
      case EmergencyServiceType.general:
        return 'خدمة عامة';
    }
  }

  IconData _typeIcon(EmergencyServiceType type) {
    switch (type) {
      case EmergencyServiceType.towing:
        return Icons.local_shipping;
      case EmergencyServiceType.fuel:
        return Icons.local_gas_station;
      case EmergencyServiceType.battery:
        return Icons.battery_charging_full;
      case EmergencyServiceType.tire:
        return Icons.tire_repair;
      case EmergencyServiceType.mobile:
        return Icons.build;
      case EmergencyServiceType.general:
        return Icons.emergency;
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstPhone = service.phones.isNotEmpty ? service.phones.first : '';

    final desc = (service.description != null && service.description!.trim().isNotEmpty)
        ? service.description!.trim()
        : 'لا يوجد وصف لهذه الخدمة حالياً.';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        // ✅ Bottom Buttons (Call + WhatsApp if available)
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
                  child: FilledButton.icon(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.errorRed,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: firstPhone.isEmpty
                        ? null
                        : () => _callPhone(context, firstPhone),
                    icon: const Icon(Iconsax.call, size: 18),
                    label: const Text(
                      "اتصال",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: (service.hasWhatsApp == true)
                            ? Colors.green
                            : Colors.grey.withOpacity(0.6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: (service.hasWhatsApp == true && firstPhone.isNotEmpty)
                        ? () => _openWhatsApp(context, firstPhone)
                        : null,
                    icon: const Icon(Iconsax.message, size: 18),
                    label: const Text(
                      "واتساب",
                      style: TextStyle(fontWeight: FontWeight.w700),
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
              tag: service.imageUrl ?? 'assets/images/placeholder.png',
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      service.imageUrl ?? 'assets/images/placeholder.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),

            Text(
              service.name,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Icon(_typeIcon(service.type), size: 18, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  _typeLabel(service.type),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (service.area != null && service.area!.trim().isNotEmpty)
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 18, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        service.area!,
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              "أرقام التواصل",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 10),

            Column(
              children: service.phones.map((p) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Iconsax.call, size: 18, color: Colors.grey),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          p,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _callPhone(context, p),
                        icon: const Icon(Iconsax.call_calling, color: AppColors.primaryBlue),
                      ),
                      if (service.hasWhatsApp == true)
                        IconButton(
                          onPressed: () => _openWhatsApp(context, p),
                          icon: const Icon(Iconsax.message, color: Colors.green),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 10),

            const Text(
              "الوصف",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 6),

            Text(
              desc,
              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:seka_app/feature/drive/learning_drive_screen.dart';
import 'package:seka_app/feature/emergency/emergency_screen.dart';
import 'package:seka_app/feature/maintenance/maintenance_screen.dart';
import 'package:seka_app/feature/marketplace/marketplace_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const Color primaryBlue = Color(0xFF004AAD);
  static const Color primaryOrange = Color(0xFFFF751E);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ServiceItem> _services(BuildContext context) => [
        ServiceItem(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DrivingSchoolScreen()),
            );
          },
          title: 'تعليم القيادة',
          imagePath: 'assets/images/learning.png',
          color: AppColors.primaryOrange,
          gradient: const LinearGradient(
            colors: [AppColors.primaryOrange, AppColors.primaryOrange],
          ),
        ),
        ServiceItem(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MaintenanceScreen()),
            );
          },
          title: 'الصيانات الدورية',
          imagePath: 'assets/images/service.png',
          color: HomeScreen.primaryBlue,
          gradient: const LinearGradient(
            colors: [Color(0xFF004AAD), Color(0xFF1565C0)],
          ),
        ),
        ServiceItem(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmergencyScreen()),
            );
          },
          title: 'طوارئ',
          imagePath: 'assets/images/emergency.png',
          color: const Color(0xFFF44336),
          gradient: const LinearGradient(
            colors: [Color(0xFFF44336), Color(0xFFE57373)],
          ),
        ),
        ServiceItem(
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MarketplaceScreen()),
            );
          },
          title: 'Marketplace',
          imagePath: 'assets/images/marketplace.png',
          color: const Color(0xFF9C27B0),
          gradient: const LinearGradient(
            colors: [Colors.green, Colors.green],
          ),
        ),
      ];

  List<ServiceItem> _filteredServices(BuildContext context) {
    final all = _services(context);
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return all;

    return all.where((s) => s.title.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final services = _filteredServices(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          backgroundColor: AppColors.lightGrey,
          elevation: 0,
          title: const Text(
            'سِكَّة',
            style: TextStyle(
              color: HomeScreen.primaryBlue,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Iconsax.notification,
                      color: HomeScreen.primaryBlue,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: HomeScreen.primaryOrange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildSearchBar(),
                _buildSectionTitle('الخدمات الرئيسية'),
                _buildServicesGrid(services),
                const SizedBox(height: 16),
                _buildQuickAccessSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          textAlign: TextAlign.right,
          onChanged: (value) => setState(() => _searchQuery = value),
          decoration: InputDecoration(
            hintText: 'ابحث عن خدمة...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            suffixIcon: Icon(Iconsax.search_normal_1, color: Colors.grey[400]),
            prefixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Iconsax.close_circle, color: Colors.grey),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: HomeScreen.primaryBlue,
        ),
      ),
    );
  }

  Widget _buildServicesGrid(List<ServiceItem> services) {
    if (services.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Center(
          child: Column(
            children: [
              Icon(Iconsax.search_status, size: 70, color: Colors.grey[300]),
              const SizedBox(height: 12),
              Text(
                'لا توجد نتائج',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _ServiceCard(service: services[index]);
        },
      ),
    );
  }

  Widget _buildQuickAccessSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الوصول السريع',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: HomeScreen.primaryBlue,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: HomeScreen.primaryOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Iconsax.calendar_1,
                    color: HomeScreen.primaryOrange,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'الصيانة القادمة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'بعد 15 يوم - تغيير زيت',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Iconsax.arrow_right_2,
                  color: HomeScreen.primaryBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String imagePath;
  final Color color;
  final Gradient? gradient;
  final VoidCallback onTap;

  ServiceItem(
    this.onTap, {
    required this.title,
    required this.imagePath,
    required this.color,
    this.gradient,
  });
}

class _ServiceCard extends StatelessWidget {
  final ServiceItem service;
  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: service.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: service.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: service.color.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                service.imagePath,
                width: 110,
                height: 110,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


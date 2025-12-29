import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/data/app_data.dart';
import 'package:seka_app/core/models/marketplace_item.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:seka_app/feature/marketplace/marketplace_details.dart';


class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  String _searchQuery = '';

  List<MarketplaceItem> get _filteredItems {
    final items = AppData.marketplaceItems;

    if (_searchQuery.trim().isEmpty) return items;

    final q = _searchQuery.toLowerCase();
    return items.where((item) {
      return item.title.toLowerCase().contains(q) ||
          item.brand.toLowerCase().contains(q) ||
          item.area.toLowerCase().contains(q) ||
          item.tags.any((t) => t.toLowerCase().contains(q));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.lightGrey,
        appBar: AppBar(
          title: const Text(
            'Marketplace',
            style: TextStyle(
              color: AppColors.primaryBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.lightGrey,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_right_3, color: AppColors.primaryBlue),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            _buildSearchBar(),
            Expanded(child: _buildGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
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
        textAlign: TextAlign.right,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'ابحث عن منتج / ماركة / منطقة...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: Icon(Iconsax.search_normal_1, color: Colors.grey[400]),
          prefixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle, color: Colors.grey),
                  onPressed: () => setState(() => _searchQuery = ''),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.search_status, size: 80, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text(
              'لا توجد نتائج',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        return _MarketplaceCard(item: _filteredItems[index]);
      },
    );
  }
}

class _MarketplaceCard extends StatelessWidget {
  final MarketplaceItem item;
  const _MarketplaceCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MarketplaceItemDetailsPage(item: item),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 0.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColors.primaryOrange.withOpacity(0.6),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ===== Logo =====
                Hero(
                  tag: item.logoUrl ?? 'logo_${item.id}',
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: AppColors.lightGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Image.asset(
                        item.logoUrl ?? 'assets/images/placeholder.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // ===== Brand / Name =====
                Text(
                  item.brand,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),

                const SizedBox(height: 6),

                // ===== Hint text =====
                Text(
                  'اضغط للتفاصيل',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


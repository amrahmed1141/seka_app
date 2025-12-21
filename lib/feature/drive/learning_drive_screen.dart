import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:seka_app/core/data/app_data.dart';
import 'package:seka_app/core/models/driving_school.dart';
import 'package:seka_app/feature/drive/driving_school_details_page.dart';

class DrivingSchoolScreen extends StatefulWidget {
  const DrivingSchoolScreen({super.key});

  @override
  State<DrivingSchoolScreen> createState() => _DrivingSchoolScreenState();
}

class _DrivingSchoolScreenState extends State<DrivingSchoolScreen> {
  String _searchQuery = '';

  List<DrivingSchool> get _filteredSchools {
    if (_searchQuery.isEmpty) {
      return AppData.drivingSchools;
    }
    return AppData.drivingSchools.where((school) {
      return school.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          school.area.toLowerCase().contains(_searchQuery.toLowerCase());
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
            'مدارس تعليم القيادة',
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
            Expanded(
              child: _buildDrivingSchoolsGrid(),
            ),
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
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'ابحث عن مدرسة قيادة أو منطقة...',
          hintStyle: TextStyle(color: Colors.grey[400]),
          suffixIcon: Icon(Iconsax.search_normal_1, color: Colors.grey[400]),
          prefixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Iconsax.close_circle, color: Colors.grey),
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
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
    );
  }

  Widget _buildDrivingSchoolsGrid() {
    if (_filteredSchools.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_status,
              size: 80,
              color: Colors.grey[300],
            ),
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
        childAspectRatio: 0.97,
      ),
      itemCount: _filteredSchools.length,
      itemBuilder: (context, index) {
        return _DrivingSchoolCard(
          school: _filteredSchools[index],
        );
      },
    );
  }
}

class _DrivingSchoolCard extends StatelessWidget {
  final DrivingSchool school;

  const _DrivingSchoolCard({
    required this.school,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DrivingSchoolDetailsPage(school: school),
    ),
  );
      },
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: AppColors.successGreen.withOpacity(0.7)),
        ),
        elevation: 0.1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section - Fixed height
            Hero(
              tag: school.imageUrl ?? 'assets/images/placeholder.png',
              child: Container(
                height: 100,
                alignment: Alignment.topRight,
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      school.imageUrl ?? 'assets/images/placeholder.png',
                    ),
                  ),
                ),
              ),
            ),

            // Text Section - Expanded to fill remaining space
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // School Name
                    Text(
                      school.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Area
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            school.area,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

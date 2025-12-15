import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:seka_app/core/theme/app_color.dart';
import 'package:seka_app/feature/booking/booking.dart';
import 'package:seka_app/feature/camera/camera.dart';
import 'package:seka_app/feature/home/home.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _currentIndex = 0;

  // Define your colors
  static const Color primaryBlue = Color(0xFF004AAD);
  static const Color primaryOrange = Color(0xFFFF751E);

  // Your pages/screens
  final List<Widget> _pages = [
    const HomeScreen(),
    const CameraScreen(),
    const BookingScreen(),
  ];

  void _onItemTapped(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final safeBottom = media.viewPadding.bottom;
    final barHeight = 80.0 + safeBottom;

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SizedBox(
        height: barHeight,
        child: Column(
          children: [
            // White background with shadow
            Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  _CenterFAB(
                    isSelected: _currentIndex == 1,
                    onPressed: () => _onItemTapped(1),
                  ),
                  _NavigationItems(
                    currentIndex: _currentIndex,
                    onTap: _onItemTapped,
                  ),
                ],
              ),
            ),
            // Safe area spacer
            Container(
              height: safeBottom,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterFAB extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;

  const _CenterFAB({
    required this.isSelected,
    required this.onPressed,
  });

  static const Color primaryOrange = Color(0xFFFF751E);

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 0.6,
      child: FloatingActionButton(
        tooltip: 'Camera',
        backgroundColor: primaryOrange,
        elevation: 3.0,
        onPressed: onPressed,
        child: Icon(
          isSelected ? Iconsax.camera5 : Iconsax.camera,
          size: 28,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _NavigationItems extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _NavigationItems({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavItem(
            index: 0,
            currentIndex: currentIndex,
            onTap: () => onTap(0),
          ),
          const SizedBox(width: 64), // Space for FAB
          _NavItem(
            index: 2,
            currentIndex: currentIndex,
            onTap: () => onTap(2),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });



  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;
    final unselectedColor = Colors.grey.shade600;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: _getLabel(index),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              HapticFeedback.selectionClick();
              onTap();
            },
            child: _NavItemContent(
              index: index,
              isSelected: isSelected,
              color: isSelected ? AppColors.primaryOrange : unselectedColor,
            ),
          ),
        ),
      ),
    );
  }

  String _getLabel(int index) {
    switch (index) {
      case 0:
        return 'الرئيسية'; // Home in Arabic
      case 2:
        return 'حجز'; // Booking in Arabic
      default:
        return '';
    }
  }
}

class _NavItemContent extends StatelessWidget {
  final int index;
  final bool isSelected;
  final Color color;

  const _NavItemContent({
    required this.index,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIconsaxIcon(),
          const SizedBox(height: 3),
          Text(
            _getLabel(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconsaxIcon() {
    const iconSize = 28.0;

    switch (index) {
      case 0: // Home
        return isSelected
            ? Icon(Iconsax.home_15, size: iconSize, color: color) // Filled
            : Icon(Iconsax.home, size: iconSize, color: color); // Outlined
      case 2: // Booking
        return isSelected
            ? Icon(Iconsax.calendar_25, size: iconSize, color: color) // Filled
            : Icon(Iconsax.calendar_2, size: iconSize, color: color); // Outlined
      default:
        return const SizedBox();
    }
  }

  String _getLabel() {
    switch (index) {
      case 0:
        return 'الرئيسية'; // Home in Arabic
      case 2:
        return 'حجز'; // Booking in Arabic
      default:
        return '';
    }
  }
}

// Placeholder screens - replace with your actual screens

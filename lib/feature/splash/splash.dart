import 'package:flutter/material.dart';
import 'package:seka_app/feature/home/home.dart';
import 'package:seka_app/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Navigate after animation completes
    Future.delayed(const Duration(seconds: 2), () {
      // Replace with your navigation logic
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const CustomBottomNavBar()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/images/logo_transparent.png',
            width: MediaQuery.sizeOf(context).width ,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;
  late Animation<double> _fadeAnimation;

  Animation<double> get bounceAnimation => _bounceAnimation;
  Animation<double> get fadeAnimation => _fadeAnimation;
  AnimationController get controller => _controller;

  void init() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.forward();

    _bounceAnimation = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.bounceOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Navigate after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    Get.delete<SplashController>();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.black),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller.controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _controller.bounceAnimation.value),
                child: Opacity(
                  opacity: _controller.fadeAnimation.value,
                  child: Image.asset(
                    'assets/images/rideLogo.png',
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

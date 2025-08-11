import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AnimatedSwitchWidget extends StatefulWidget {
  const AnimatedSwitchWidget({super.key});

  @override
  State<AnimatedSwitchWidget> createState() => _AnimatedSwitchWidgetState();
}

class _AnimatedSwitchWidgetState extends State<AnimatedSwitchWidget>
    with SingleTickerProviderStateMixin {
  bool isOnline = false;
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSwitch() {
    setState(() {
      isOnline = !isOnline;
    });

    if (isOnline) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSwitch,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: Get.width * 0.4,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isOnline ? Color(0xFF4CAF50) : Color(0xFFADB3BC),
        ),
        child: Stack(
          children: [
            // Text positioning
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: isOnline ? 19 : Get.width * 0.4 - 80,
              top: 8,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: 1.0,
                child: Text(
                  isOnline ? "Online" : "Offline",
                  style: GoogleFonts.manrope(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            // Animated CircleAvatar
            AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                double maxSlide = Get.width * 0.4 - 40;
                return Positioned(
                  left: 5 + (_slideAnimation.value * maxSlide),
                  top: 5,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: FaIcon(
                      FontAwesomeIcons.car,
                      color: isOnline ? Color(0xFF4CAF50) : Color(0xFFADB3BC),
                      size: 16,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

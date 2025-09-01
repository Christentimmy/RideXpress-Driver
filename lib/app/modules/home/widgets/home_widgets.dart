import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/network_controller.dart';

class AnimatedSwitchWidget extends StatelessWidget {
  AnimatedSwitchWidget({super.key});

  final networkController = Get.find<NetworkController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: Get.width * 0.4,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: networkController.isOnline.value
              ? Color(0xFF4CAF50)
              : Color(0xFFADB3BC),
        ),
        child: Row(
          children: [
             const SizedBox(width: 5),
            // Text positioning
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: FaIcon(
                FontAwesomeIcons.car,
                color: networkController.isOnline.value
                    ? Color(0xFF4CAF50)
                    : Color(0xFFADB3BC),
                size: 16,
              ),
            ),
            SizedBox(width: Get.width * 0.07),
            Text(
              networkController.isOnline.value ? "Online" : "Offline",
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:ridexpressdriver/app/controller/timer_controller.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});

  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        onPressed: () {
          Get.toNamed(AppRoutes.uploadProfile);
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.1),
            Center(
              child: Text(
                'Verification',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              'Kindly enter the OTP sent to your\nmobile phone',
              style: Get.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.08),
            Center(
              child: Pinput(
                onCompleted: (value) {
                  Get.toNamed(AppRoutes.uploadProfile);
                },
                defaultPinTheme: PinTheme(
                  width: 45,
                  height: 45,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() {
              if (timerController.secondsRemaining.value <= 0) {
                return Center(
                  child: Text(
                    "Resend",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Resend code in  "),
                  Text(
                    timerController.secondsRemaining.value.toString(),
                    style: Get.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

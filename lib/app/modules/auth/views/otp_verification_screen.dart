import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:ridexpressdriver/app/controller/auth_controller.dart';
import 'package:ridexpressdriver/app/controller/timer_controller.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/utils/loaders.dart';


class OtpVerificationScreen extends StatelessWidget {
  final String email;
  final VoidCallback? whatNext;
  OtpVerificationScreen({super.key, required this.email, this.whatNext});

  final timerController = Get.put(TimerController());
  final authController = Get.find<AuthController>();

  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        onPressed: () async {
          await authController.verifyOtp(
            otpCode: otpController.text,
            email: email,
            whatNext: whatNext,
          );
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
      body: Stack(
        children: [
          Padding(
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
                  'Kindly enter the OTP sent to\n$email',
                  style: Get.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Get.height * 0.08),
                Center(
                  child: Pinput(
                    onCompleted: (value) async {
                      await authController.verifyOtp(
                        otpCode: value,
                        email: email,
                        whatNext: whatNext,
                      );
                    },
                    defaultPinTheme: PinTheme(
                      width: 45,
                      height: 45,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      decoration: const BoxDecoration(
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
                    return InkWell(
                      onTap: () async {
                        timerController.startTimer();
                        await authController.sendOtp(email: email);
                      },
                      child: Center(
                        child: Text(
                          "Resend",
                          style: Get.textTheme.bodyMedium!.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Resend code in  "),
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

          // 👇 Loader Overlay
          Obx(() {
            if (authController.isOtpVerifyLoading.value) {
              return Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.65),
                  child: const Center(child: Loader2()),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

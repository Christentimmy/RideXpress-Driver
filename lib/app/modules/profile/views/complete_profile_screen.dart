import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';
import 'package:ridexpressdriver/app/widgets/staggered_column_animation.dart';

class CompleteProfileScreen extends StatelessWidget {
  CompleteProfileScreen({super.key});

  final RxBool isCheckValue = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: StaggeredColumnAnimation(
          children: [
            SizedBox(height: Get.height * 0.01),
            Center(
              child: Text(
                "Getting you started",
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "Welcome! Let’s quickly kick things off by inputting your details as required.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            CustomTextField(
              prefixIcon: FontAwesomeIcons.user,
              hintText: "First Name",
            ),
            const SizedBox(height: 15),
            CustomTextField(
              prefixIcon: FontAwesomeIcons.user,
              hintText: "Last Name",
            ),
            const SizedBox(height: 15),
            CustomTextField(
              prefixIcon: FontAwesomeIcons.user,
              hintText: "Email Address",
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "We’ll  use this to send you important updates and trip confirmation",
                style: GoogleFonts.poppins(fontSize: 8, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 15),
            CustomTextField(
              prefixIcon: FontAwesomeIcons.lock,
              hintText: "Password",
            ),
            const SizedBox(height: 15),
            CustomTextField(
              prefixIcon: FontAwesomeIcons.lock,
              hintText: "Confirm Password",
            ),

            const SizedBox(height: 30),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: isCheckValue.value,
                    visualDensity: VisualDensity.compact,
                    activeColor: AppColors.primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      isCheckValue.value = value!;
                    },
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'I agree to the ',
                          style: GoogleFonts.poppins(fontSize: 10),
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: ' and ',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            CustomButton(
              ontap: () {
                // Get.toNamed(AppRoutes.notifcationRequest);
              },
              isLoading: false.obs,
              child: Text(
                "Continue",
                style: Get.textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

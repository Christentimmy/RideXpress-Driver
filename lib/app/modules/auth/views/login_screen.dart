import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.35,
            width: Get.width,
            padding: EdgeInsets.only(top: 50),
            color: AppColors.primaryColor,
            child: Image.asset("assets/images/manoncab.png"),
          ),
          SizedBox(height: Get.height * 0.05),
          Center(
            child: Text(
              'Sign In',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 3),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(15, 0, 0, 0),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                CountryCodePicker(
                  onChanged: (code) {},
                  showCountryOnly: true,
                  showOnlyCountryWhenClosed: false,
                  margin: EdgeInsets.only(right: 5),
                  padding: EdgeInsets.zero,
                  initialSelection: 'GB',
                  alignLeft: false,
                  searchStyle: Get.textTheme.bodyMedium,
                ),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Phone Number',
                    keyboardType: TextInputType.phone,
                    contentPadding: EdgeInsets.zero,
                    controller: TextEditingController(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: Get.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Enter your number',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'We will send a code to verify your mobile number',
              style: GoogleFonts.manrope(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
              ontap: () {
                Get.toNamed(AppRoutes.bottomNavigationWidget);
              },
              isLoading: false.obs,
              child: Text(
                "Login",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

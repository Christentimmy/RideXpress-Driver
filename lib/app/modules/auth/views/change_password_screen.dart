import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Change Password',
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height * 0.04),
              _buildStackImage(),
              SizedBox(height: Get.height * 0.06),
              Text(
                "Current Password",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFADB3BC),
                ),
              ),
              CustomTextField(
                isObscure: true,
                hintText: "***************",
                hintStyle: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF858585),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFADB3BC)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "New Password",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFADB3BC),
                ),
              ),
              CustomTextField(
                isObscure: true,
                hintText: "***************",
                hintStyle: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF858585),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFADB3BC)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Text(
                "Confirm New Password",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFADB3BC),
                ),
              ),
              CustomTextField(
                isObscure: true,
                hintText: "***************",
                hintStyle: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF858585),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFADB3BC)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(height: Get.height * 0.05),
              Center(
                child: CustomButton(
                  ontap: () {},
                  width: Get.width * 0.45,
                  isLoading: false.obs,
                  child: Text(
                    "Save",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStackImage() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Color.fromARGB(255, 255, 225, 135),
            backgroundImage: AssetImage("assets/images/ai.jpg"),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

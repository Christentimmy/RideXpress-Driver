import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final RxBool isObScure = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: Get.height * 0.05),
              _buildFormFields(),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildFormFields() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CustomTextField(
              prefixIcon: Icons.person,
              prefixIconColor: AppColors.primaryColor,
              controller: TextEditingController(),
              hintText: "Full Name",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              prefixIcon: Icons.email,
              prefixIconColor: AppColors.primaryColor,
              controller: TextEditingController(),
              hintText: "Email Address",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              prefixIcon: Icons.lock,
              prefixIconColor: AppColors.primaryColor,
              controller: TextEditingController(),
              hintText: "Enter password",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              prefixIcon: Icons.home,
              prefixIconColor: AppColors.primaryColor,
              controller: TextEditingController(),
              hintText: "State of Residence",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              prefixIcon: Icons.home,
              prefixIconColor: AppColors.primaryColor,
              controller: TextEditingController(),
              hintText: "City",
            ),
            SizedBox(height: Get.height * 0.12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.phoneNumberAuthentication);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(Icons.arrow_forward, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      height: Get.height * 0.25,
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              height: Get.height * 0.25,
              width: Get.width,
              color: AppColors.primaryColor,
            ),
          ),
          Image.asset("assets/images/maskGroup.png"),
          Positioned(right: 0, child: Image.asset("assets/images/cab.png")),
          Positioned(
            bottom: Get.height * 0.07,
            left: Get.width * 0.05,
            child: Text(
              'Sign Up as\nDriver',
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class VehicleDetailsScreen extends StatelessWidget {
  const VehicleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: Get.height * 0.05),
            _buildFormFields(),
          ],
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
              controller: TextEditingController(),
              hintText: "Vehicle Registration Number",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Vehicle Color",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Enter Vehicle Make",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Enter Vehicle Model",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Licensed Plate Number",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: TextEditingController(),
              hintText: "Enter Vehicle Year",
            ),
            SizedBox(height: Get.height * 0.03),
            CustomButton(
              isLoading: false.obs,
              child: Text(
                "Save",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              ontap: () {
                Get.toNamed(AppRoutes.submitDocuments);
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      color: Color(0xFFFFF5DC),
      height: Get.height * 0.33,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.08),
            Icon(Icons.arrow_back),

            SizedBox(height: Get.height * 0.02),
            Center(
              child: Text(
                "Vehicle Details",
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Kindly provide the details of your\nvehicle below to begin the\nregistration process",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: Color(0xFF898A8D),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

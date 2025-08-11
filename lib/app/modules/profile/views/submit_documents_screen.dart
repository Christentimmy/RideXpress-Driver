import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class SubmitDocumentsScreen extends StatelessWidget {
  const SubmitDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: Get.height * 0.05),
            _buildTile(
              title: "Driver’s License",
              icon: FontAwesomeIcons.idCard,
              onTap: () {
                Get.toNamed(AppRoutes.documentDisclaimer);
              },
            ),
            _buildTile(
              title: "HC - Vehicle Licence",
              icon: FontAwesomeIcons.car,
              onTap: () {
                Get.toNamed(
                  AppRoutes.uploadDocScreen,
                  arguments: {"title": "HC - Vehicle Licence"},
                );
              },
            ),
            _buildTile(
              title: "Vehicle Insurance",
              icon: FontAwesomeIcons.car,
              onTap: () {
                Get.toNamed(
                  AppRoutes.uploadDocScreen,
                  arguments: {"title": "Vehicle Insurance"},
                );
              },
            ),
            _buildTile(
              title: "MOT Certificate",
              icon: FontAwesomeIcons.solidIdBadge,
              onTap: () {
                Get.toNamed(
                  AppRoutes.uploadDocScreen,
                  arguments: {"title": "MOT Certificate"},
                );
              },
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Why is this needed?",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
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
                  Get.offAllNamed(AppRoutes.bottomNavigationWidget);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        leading: FaIcon(icon, color: AppColors.primaryColor),
        title: Text(
          title,
          style: GoogleFonts.manrope(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
          ),
        ),
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _buildHeader() {
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
                "Submit Documents",
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
                "We need to verify your vehicle\nPlease submit the document below\nto process the application",
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

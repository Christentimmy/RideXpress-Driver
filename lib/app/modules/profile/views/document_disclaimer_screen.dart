import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class DocumentDisclaimerScreen extends StatelessWidget {
  const DocumentDisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.xmark),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Center(
              child: Text(
                "Driver’s License",
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  color: Color(0xFF555555),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            Image.asset("assets/images/id.png"),
            SizedBox(height: Get.height * 0.05),
            Center(
              child: Text(
                "Before you upload the document and\nit get verified, kindly ensure that:",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: Color(0xFF898A8D),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.05),
            _buildTile(title: "It hasn’t expired"),
            _buildTile(title: "It is clear and easy to read"),
            _buildTile(
              title: "The entire driver’s license is in the scanning frame",
            ),
            SizedBox(height: Get.height * 0.05),
            CustomButton(
              isLoading: false.obs,
              ontap: () {
                Get.offNamed(AppRoutes.scanScreen);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Scan Document",
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
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

  ListTile _buildTile({required String title}) {
    return ListTile(
      leading: Icon(Icons.verified, color: Colors.green),
      horizontalTitleGap: 10,
      minTileHeight: 40,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          color: Color(0xFF898A8D),
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}

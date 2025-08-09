import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Column(children: [_buildHeader()])),
    );
  }

  SizedBox _buildHeader() {
    return SizedBox(
      height: Get.height * 0.41,
      child: Stack(
        children: [
          _buildBg(),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 50),
            child: Row(
              children: [
                Icon(Icons.arrow_back),
                SizedBox(width: 20),
                Text(
                  "Settings",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Get.height * 0.12,
            left: Get.width * 0.365,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage("assets/images/ai.jpg"),
                  ),
                ),
                Text(
                  "John Doe",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Driver",
                  style: GoogleFonts.manrope(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              height: Get.height * 0.08,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              margin: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "3,251",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Trips",
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          // SizedBox(width: 3),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4.99",
                            style: GoogleFonts.manrope(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 22,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Ratings",
                            style: GoogleFonts.manrope(
                              fontSize: 13,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "2",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        "Months",
                        style: GoogleFonts.manrope(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBg() {
    return SizedBox(
      height: Get.height * 0.37,
      width: Get.width,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              height: Get.height * 0.4,
              width: Get.width,
              color: Color(0xFFFFEBB6),
            ),
          ),
          Image.asset("assets/images/newMask.png"),
        ],
      ),
    );
  }
}

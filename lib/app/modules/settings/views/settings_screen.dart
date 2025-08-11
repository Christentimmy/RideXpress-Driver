import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: Get.height * 0.06),
            Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                'Account Settings',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              title: 'Your Info',
              subtitle: 'Account, Personal',
              onTap: () {
                Get.toNamed(AppRoutes.editProfileScreen);
              },

            ),
            // _buildSettingItem(
            //   title: 'Document',
            //   subtitle: 'Driver’s License, Report',
            //   showInfo: true,
            // ),
            _buildSettingItem(
              title: 'Security',
              subtitle: 'Password, TouchID',
              onTap: () {
                Get.toNamed(AppRoutes.changePasswordScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String subtitle,
    bool showInfo = false,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: const Icon(Icons.person, color: Color(0xFFFFC107)),
      title: Text(
        title,
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(subtitle, style: GoogleFonts.manrope(color: Colors.grey)),
      trailing: showInfo
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.info, color: Color(0xFFFFC107)),
                Icon(Icons.chevron_right),
              ],
            )
          : const Icon(Icons.chevron_right),
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
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.tripsStatsScreen);
                    },
                    child: Column(
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
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.ratingStatScreen);
                    },
                    child: Column(
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

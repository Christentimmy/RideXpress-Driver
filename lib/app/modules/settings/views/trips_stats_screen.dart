import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class TripsStatsScreen extends StatelessWidget {
  const TripsStatsScreen({super.key});

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
                'Recent Reviews',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _buildReviewCard(title: 'Tomi Ayo', subtitle: 'Account, Personal'),
            _buildReviewCard(
              title: 'James Bayo',
              subtitle: 'Driver’s License, Report',
            ),
            _buildReviewCard(
              title: 'Richard Brown',
              subtitle: 'Password, TouchID',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard({required String title, required String subtitle}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage("assets/images/ai.jpg"),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "(2 days ago)",
            style: GoogleFonts.manrope(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.manrope(color: Colors.grey, fontSize: 11),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, color: Color(0xFFFFC107)),
          Text("4.5", style: GoogleFonts.manrope(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
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
                  "Ratings",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: Get.height * 0.18,
            left: Get.width * 0.4,
            child: Column(
              children: [
                Text(
                  "3,251",
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Trips",
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
                        "4500",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        "Trips",
                        style: GoogleFonts.manrope(
                          fontSize: 11,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.acceptanceScreen);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "92%",
                              style: GoogleFonts.manrope(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        Text(
                          "Acceptance Rate",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.cancellationRateScreen);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "2%",
                              style: GoogleFonts.manrope(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 22,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                        Text(
                          "Cancellation Rate",
                          style: GoogleFonts.manrope(
                            fontSize: 11,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
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

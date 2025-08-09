import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class RatingStatScreen extends StatelessWidget {
  const RatingStatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        title: Text(
          "Ratings",
          style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.3,
              color: const Color.fromARGB(255, 247, 245, 245),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "4.99",
                        style: GoogleFonts.manrope(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ],
                  ),
                  Text(
                    "Ratings",
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            _buildRatingTile(title: "5", rating: "88%", percentage: 0.9),
            SizedBox(height: Get.height * 0.02),
            _buildRatingTile(title: "4", rating: "25%", percentage: 0.25),
            SizedBox(height: Get.height * 0.02),
            _buildRatingTile(title: "3", rating: "6%", percentage: 0.06),
            SizedBox(height: Get.height * 0.02),
            _buildRatingTile(title: "2", rating: "2%", percentage: 0.02),
            SizedBox(height: Get.height * 0.02),
            _buildRatingTile(title: "1", rating: "2%", percentage: 0.1),
            SizedBox(height: Get.height * 0.1),
            Center(
              child: Text(
                "Your rider rate trip is based on the scale of\n1-5 stars. Your ratings is the average of rider’s\nratings from your last 3,251 Trips",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildRatingTile({
    required String title,
    required String rating,
    required double percentage,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Icon(Icons.star, color: Colors.orange),
          Text(title, style: GoogleFonts.manrope(fontSize: 15)),
          SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 10,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(width: 10),
          Text(
            rating,
            style: GoogleFonts.manrope(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

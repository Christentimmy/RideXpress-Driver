import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class RatingStatScreen extends StatefulWidget {
  const RatingStatScreen({super.key});

  @override
  State<RatingStatScreen> createState() => _RatingStatScreenState();
}

class _RatingStatScreenState extends State<RatingStatScreen> {
  final _userController = Get.find<UserController>();

  @override
  void initState() {
    _userController.getAllRatings();
    super.initState();
  }

  // Calculate average rating
  // double _calculateAverageRating() {
  //   if (_userController.ratings.isEmpty) return 0.0;

  //   double total = 0;
  //   for (var rating in _userController.ratings) {
  //     if (rating.riderRating != null) {
  //       total += rating.riderRating!;
  //     }
  //   }
  //   return total / _userController.ratings.length;
  // }

  // Calculate rating distribution
  Map<int, int> _calculateRatingDistribution() {
    final distribution = <int, int>{};
    // Initialize all possible ratings (1-5) with 0
    for (int i = 1; i <= 5; i++) {
      distribution[i] = 0;
    }

    // Count each rating
    for (var rating in _userController.ratings) {
      if (rating.riderRating != null) {
        final int roundedRating = rating.riderRating!.round();
        distribution[roundedRating] = (distribution[roundedRating] ?? 0) + 1;
      }
    }

    return distribution;
  }

  // Get percentage of a specific rating
  String _getRatingPercentage(int rating, Map<int, int> distribution) {
    if (_userController.ratings.isEmpty) return '0%';
    final count = distribution[rating] ?? 0;
    final percentage = (count / _userController.ratings.length) * 100;
    return '${percentage.toStringAsFixed(0)}%';
  }

  // Get percentage as double for progress indicator (0.0 to 1.0)
  double _getRatingPercentageValue(int rating, Map<int, int> distribution) {
    if (_userController.ratings.isEmpty) return 0.0;
    final count = distribution[rating] ?? 0;
    return count / _userController.ratings.length;
  }

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
                      Obx(() {
                        final userModel = _userController.userModel.value;
                        if (userModel == null) return const SizedBox.shrink();
                        // return Text(
                        //   _calculateAverageRating().toStringAsFixed(2),
                        //   style: GoogleFonts.manrope(
                        //     fontSize: 35,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // );
                        return Text(
                          userModel.totalAvgRating?.toStringAsFixed(2) ?? "",
                          style: GoogleFonts.manrope(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
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
            Obx(() {
              if (_userController.isloading.value) {
                return SizedBox(
                  height: Get.height * 0.34,
                  width: Get.width,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (_userController.ratings.isEmpty) {
                return SizedBox(
                  height: Get.height * 0.34,
                  width: Get.width,
                  child: const Center(child: Text('No ratings yet')),
                );
              }
              final distribution = _calculateRatingDistribution();
              return Column(
                children: [
                  _buildRatingTile(
                    title: "5",
                    rating: _getRatingPercentage(5, distribution),
                    percentage: _getRatingPercentageValue(5, distribution),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  _buildRatingTile(
                    title: "4",
                    rating: _getRatingPercentage(4, distribution),
                    percentage: _getRatingPercentageValue(4, distribution),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  _buildRatingTile(
                    title: "3",
                    rating: _getRatingPercentage(3, distribution),
                    percentage: _getRatingPercentageValue(3, distribution),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  _buildRatingTile(
                    title: "2",
                    rating: _getRatingPercentage(2, distribution),
                    percentage: _getRatingPercentageValue(2, distribution),
                  ),
                  SizedBox(height: Get.height * 0.02),
                  _buildRatingTile(
                    title: "1",
                    rating: _getRatingPercentage(1, distribution),
                    percentage: _getRatingPercentageValue(1, distribution),
                  ),
                ],
              );
            }),
            SizedBox(height: Get.height * 0.1),
            Center(
              child: Text(
                "Your rider rate trip is based on the scale of\n1-5 stars. Your ratings is the average of rider's\nratings from your last ${_userController.ratings.length} Trips",
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

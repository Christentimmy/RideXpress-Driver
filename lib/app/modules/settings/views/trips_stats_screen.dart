import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/rating_model.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class TripsStatsScreen extends StatefulWidget {
  const TripsStatsScreen({super.key});

  @override
  State<TripsStatsScreen> createState() => _TripsStatsScreenState();
}

class _TripsStatsScreenState extends State<TripsStatsScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.ratings.isEmpty) {
        userController.getAllRatings();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await userController.getAllRatings();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
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
              Obx(() {
                if (userController.isloading.value) {
                  return SizedBox(
                    height: Get.height * 0.35,
                    width: Get.width,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  );
                }
                if (userController.ratings.isEmpty) {
                  return SizedBox(
                    height: Get.height * 0.35,
                    width: Get.width,
                    child: Center(child: Text("No ratings yet")),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: userController.ratings.length,
                  itemBuilder: (context, index) {
                    final rating = userController.ratings[index];
                    return _buildReviewCard(rating: rating);
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewCard({required RatingModel rating}) {
    return ListTile(
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage("assets/images/ai.jpg"),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${rating.rider?.firstName} ${rating.rider?.lastName}",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 10),
          Text(
            "${DateTime.now().difference(rating.createdAt ?? DateTime.now()).inDays} days ago",
            style: GoogleFonts.manrope(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
      subtitle: Text(
        rating.riderComment ?? "",
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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final rides = userController.totalRides.value;
                  return Text(
                    rides.toString(),
                    style: GoogleFonts.manrope(
                      fontSize: 30,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
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
                            Obx(() {
                              final acceptanceRate =
                                  userController.acceptanceRatePercentage.value;
                              return Text(
                                "$acceptanceRate%",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }),
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
                            Obx(() {
                              final cancellationRate = userController
                                  .cancellationRatePercentage
                                  .value;
                              return Text(
                                "$cancellationRate%",
                                style: GoogleFonts.manrope(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            }),
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

import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/modules/home/widgets/online_switch_widget.dart';
import 'package:ridexpressdriver/app/modules/home/widgets/ride_request_card.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RxString tripStatus = "".obs;

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.getRideRequest();
      userController.getTodayRideSummary();
    });
  }

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(51.507351, -0.127758),
                zoom: 15.0,
              ),
              onMapCreated: (controller) {
                final location = userController.userModel.value?.location;
                if (location == null) {
                  return;
                }
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: LatLng(location.lat!, location.lng!),
                      zoom: 15.0,
                    ),
                  ),
                );
              },
            ),

            _buildHeader(),
            Obx(() {
              if (userController.rideRequestLoading.value) {
                return buildLoder();
              }
              if (userController.rideRequestList.isEmpty) {
                return _buildEmptyRide();
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: IntrinsicHeight(
                  child: AppinioSwiper(
                    cardCount: userController.rideRequestList.length,
                    cardBuilder: (context, index) {
                      final rideRequest = userController.rideRequestList[index];
                      return RideRequestCard(rideRequest: rideRequest);
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Align buildLoder() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.3,
        width: Get.width,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.05,
          horizontal: 15,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: Get.height * 0.02,
        left: 15,
        right: 15,
        bottom: 15,
      ),
      child: Row(
        children: [
          Obx(() {
            final userModel = userController.userModel.value;
            return CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(userModel?.avatar ?? ""),
            );
          }),
          Spacer(),
          AnimatedSwitchWidget(),
          Spacer(),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: FaIcon(FontAwesomeIcons.filter, color: Color(0xFFADB3BC)),
          ),
        ],
      ),
    );
  }

  Align _buildEmptyRide() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: Get.height * 0.3,
        width: Get.width,
        margin: EdgeInsets.symmetric(
          vertical: Get.height * 0.05,
          horizontal: 15,
        ),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today’s Summary",
              style: GoogleFonts.manrope(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "Total Trips Today",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.car, color: AppColors.primaryColor),
                SizedBox(width: 10),
                Obx(
                  () => Text(
                    "${userController.totalRidesToday.value} Trips",
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

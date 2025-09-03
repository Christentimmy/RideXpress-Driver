import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/modules/home/widgets/home_widgets.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class TripStatusScreen extends StatelessWidget {
  final RideModel rideModel;
  TripStatusScreen({super.key, required this.rideModel});
  final userController = Get.find<UserController>();

  final RxString rideStatus = "".obs;

  @override
  Widget build(BuildContext context) {
    rideStatus.value = rideModel.status?.value ?? "";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildlMap(),
            _buildHeader(),
            buildTripStatus(),
          ],
        ),
      ),
    );
  }

  GoogleMap buildlMap() {
    return GoogleMap(
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
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/ai.jpg"),
          ),
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

  Widget buildTripStatus() {
    return Obx(() {
      if (rideStatus.value == "") return _buildEmptyRide();
      if (rideStatus.value == "accepted") return _buildRideAccepted();
      if (rideStatus.value == "arrived") return _buildRideArrived();
      if (rideStatus.value == "tripStarted") return _builTripStarted();
      if (rideStatus.value == "destinationReached") {
        return _buildDestinationReached();
      }
      return _buildEmptyRide();
    });
  }

  Widget _buildDestinationReached() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Arrived Destination!",
                  style: GoogleFonts.manrope(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 5),
                Text("You just arrived at the  destination address"),
                SizedBox(height: 5),
                Text(
                  "Alausa, Ikeja",
                  style: GoogleFonts.manrope(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomButton(
              ontap: () {
                Get.toNamed(AppRoutes.rateDriverScreen);
              },
              isLoading: false.obs,
              height: 45,
              borderRadius: BorderRadius.circular(10),
              child: Text(
                "Complete Trip",
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builTripStarted() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "24 Min",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("KINGDOM TOWER"),
                      SizedBox(height: 5),
                      Text(
                        "Alausa, Ikeja",
                        style: GoogleFonts.manrope(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.chatScreen);
                      },
                      child: Icon(Icons.message),
                    ),
                    SizedBox(height: Get.height * 0.03),
                    InkWell(
                      onTap: () {
                        _displayEmergencyBottomSheet();
                      },
                      child: Icon(
                        FontAwesomeIcons.solidLightbulb,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomButton(
              ontap: () {
                rideModel.status!.value = "destinationReached";
              },
              isLoading: false.obs,
              height: 45,
              borderRadius: BorderRadius.circular(10),
              child: Text(
                "End Trip",
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRideArrived() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1:35 Waiting",
                        style: GoogleFonts.manrope(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text("You’ve arrived at the pick up location"),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Joshua Tobi",
                            style: GoogleFonts.manrope(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 5),
                          FaIcon(
                            FontAwesomeIcons.solidStar,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "4.5",
                            style: GoogleFonts.manrope(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _displayCancelBottomSheet();
                  },
                  child: Text(
                    "Cancel Ride",
                    style: GoogleFonts.manrope(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            CustomButton(
              isLoading: false.obs,
              height: 45,
              borderRadius: BorderRadius.circular(10),
              ontap: () {
                // tripStatus.value = "tripStarted";
                // Future.delayed(Duration(seconds: 40), () {
                //   tripStatus.value = "destinationReached";
                // });
              },
              child: Text(
                "Start Up",
                style: GoogleFonts.manrope(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _displayCancelBottomSheet() {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Why are you canceling?",
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2936),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Center(
                child: Text(
                  "Rider didn’t show",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Rider requested cancel",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Wrong address shown",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Other",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _displayEmergencyBottomSheet() {
    return showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Emergency",
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1B2936),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Center(
                child: Text(
                  "Contact Support",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Car Accident",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Vehicle Issue",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
              SizedBox(height: Get.height * 0.01),
              Center(
                child: Text(
                  "Other",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRideAccepted() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: Get.width,
          height: 55,
          color: Color(0xFFFFF5DC),
          child: Row(
            children: [
              SizedBox(width: 20),
              FaIcon(FontAwesomeIcons.bell, color: AppColors.primaryColor),
              SizedBox(width: 10),
              Text(
                "Rider Notified",
                style: GoogleFonts.manrope(color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${rideModel.eta?.minutes} mins",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(rideModel.pickupLocation?.address ?? ""),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "${rideModel.riderModel?.firstName} ${rideModel.riderModel?.lastName}",
                              style: GoogleFonts.manrope(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 5),
                            // FaIcon(
                            //   FontAwesomeIcons.solidStar,
                            //   color: AppColors.primaryColor,
                            //   size: 18,
                            // ),
                            // SizedBox(width: 5),
                            // Text(
                            //   "4.5",
                            //   style: GoogleFonts.manrope(
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.w700,
                            //     color: AppColors.primaryColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text("${rideModel.eta?.distance} Km"),
                ],
              ),
              SizedBox(height: 15),
              CustomButton(
                isLoading: userController.isloading,
                bgColor: Colors.white,

                border: Border.all(width: 1, color: AppColors.primaryColor),
                loaderColor: AppColors.primaryColor,
                child: Text(
                  "Arrived",
                  style: GoogleFonts.manrope(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ontap: () async {
                  await userController.arrivedAtPickUp(
                    rideId: rideModel.id!,
                    status: rideStatus,
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.028),
      ],
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
                Text(
                  "9 Trips",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
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

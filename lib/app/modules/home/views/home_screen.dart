import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridexpressdriver/app/controller/location_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/modules/home/widgets/home_widgets.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

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
      Get.find<LocationController>().initializeLocation();
    });
    // Future.delayed(Duration(seconds: 10), () {
    //   tripStatus.value = "rides";
    // });
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
                      return _buildRides(rideRequest: rideRequest);
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

  Widget buildTripStatus(String status) {
    switch (status) {
      case "":
        return _buildEmptyRide();
      case "rides":
        return _buildRides(rideRequest: RideModel());
      case "rideAccepted":
        return _buildRideAccepted();
      case "rideArrived":
        return _buildRideArrived();
      case "tripStarted":
        return _builTripStarted();
      case "destinationReached":
        return _buildDestinationReached();
      default:
        return _buildEmptyRide();
    }
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
                tripStatus.value = "destinationReached";
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
                tripStatus.value = "tripStarted";
                Future.delayed(Duration(seconds: 40), () {
                  tripStatus.value = "destinationReached";
                });
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
                          "2 mins",
                          style: GoogleFonts.manrope(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("Joseph Babalola Road, Alausa"),
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
                  Text("20 Mileage"),
                ],
              ),
              SizedBox(height: 15),
              CustomButton(
                isLoading: false.obs,
                bgColor: Colors.white,
                border: Border.all(width: 1, color: Colors.grey),
                child: Text(
                  "Arriving Pick Up",
                  style: GoogleFonts.manrope(color: Colors.grey, fontSize: 15),
                ),
                ontap: () {},
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

  Widget _buildRides({required RideModel rideRequest}) {
    return InkWell(
      onTap: () {
        rideRequest.isExpanded.value = !rideRequest.isExpanded.value;
      },
      child: Obx(
        () => Container(
          width: Get.width,
          height: rideRequest.isExpanded.value
              ? Get.height * 0.4
              : Get.height * 0.25,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  width: Get.width * 0.4,
                  child: Obx(
                    () => rideRequest.isExpanded.value
                        ? Icon(Icons.keyboard_arrow_up_rounded)
                        : Icon(Icons.keyboard_arrow_down_rounded),
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    rideRequest.riderModel?.avatar ?? "",
                  ),
                ),
                title: Text(
                  "${rideRequest.riderModel?.firstName} ${rideRequest.riderModel?.lastName}",
                  style: GoogleFonts.manrope(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  rideRequest.status?.value ?? "",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${rideRequest.eta?.distance}km",
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${rideRequest.eta?.minutes} mins",
                      style: GoogleFonts.manrope(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return rideRequest.isExpanded.value
                    ? Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              "Pickup Location",
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              rideRequest.pickupLocation?.address ?? "",
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(Icons.location_on),
                            title: Text(
                              "Drop Off Location",
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              rideRequest.dropOffLocation?.address ?? "",
                              style: GoogleFonts.manrope(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink();
              }),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: userController.isloading,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      borderRadius: BorderRadius.circular(20),
                      bgColor: Colors.green,
                      ontap: () async {
                        if (rideRequest.id == null) return;
                        await userController.acceptRide(
                          rideId: rideRequest.id!,
                        );    
                        // tripStatus.value = "rideAccepted";
                        // await Future.delayed(Duration(seconds: 40), () {
                        //   tripStatus.value = "rideArrived";
                        // });
                      },
                      child: Text(
                        "Accept",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      height: 40,
                      borderRadius: BorderRadius.circular(20),
                      isLoading: false.obs,
                      ontap: () {
                        tripStatus.value = "";
                      },
                      bgColor: Colors.red,
                      child: Text(
                        "Decline",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

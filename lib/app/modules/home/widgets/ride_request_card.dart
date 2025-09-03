import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class RideRequestCard extends StatelessWidget {
  final RideModel rideRequest;
  RideRequestCard({super.key, required this.rideRequest});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        rideRequest.isExpanded.value = !rideRequest.isExpanded.value;
      },
      child: Obx(
        () => AnimatedContainer(
          duration: Duration(milliseconds: 300), // animation speed
          curve: Curves.easeInOut, // animation curve
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
                    () => AnimatedRotation(
                      turns: rideRequest.isExpanded.value
                          ? 0.5
                          : 0, // rotate arrow
                      duration: Duration(milliseconds: 300),
                      child: Icon(Icons.keyboard_arrow_down_rounded),
                    ),
                  ),
                ),
              ),
              // rest of your widget remains the same...
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
                return AnimatedCrossFade(
                  duration: Duration(milliseconds: 300),
                  secondCurve: Curves.bounceOut,
                  firstChild: SizedBox.shrink(),
                  secondChild: Column(
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
                  ),
                  crossFadeState: rideRequest.isExpanded.value
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                );
              }),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isLoading: userController.isAcceptLoading,
                      height: 40,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      borderRadius: BorderRadius.circular(20),
                      bgColor: Colors.green,
                      ontap: () async {
                        if (rideRequest.id == null) return;
                        await userController.acceptRide(
                          rideId: rideRequest.id!,
                        );
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
                      isLoading: userController.isDeclineLoading,
                      ontap: () async {
                        if (rideRequest.id == null) return;
                        await userController.declineRide(
                          rideId: rideRequest.id!,
                        );
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

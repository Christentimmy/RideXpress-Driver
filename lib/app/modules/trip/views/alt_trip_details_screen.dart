import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class AltTripDetailsScreen extends StatelessWidget {
  const AltTripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusHeader(),
              SizedBox(height: 10),
              ListTile(
                minTileHeight: 45,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(Icons.location_on, color: Colors.green),
                title: Text(
                  "Ikeja City Mall, Alausa Road",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Text(
                  "2:21pm",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              ListTile(
                minTileHeight: 45,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: Icon(Icons.location_on, color: Colors.orange),
                title: Text(
                  "Shoprite Event Centre, Ikeja",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Text(
                  "1:21pm",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.244,
                width: double.infinity,
                child: GoogleMap(
                  mapType: MapType.terrain,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(target: LatLng(0, 0)),
                ),
              ),
              SizedBox(height: 10),
              _buildTripInfoDetails(),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage("assets/images/ai.jpg"),
                ),
                title: Text(
                  "John Doe",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text(
                      "4.5",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Container(
                width: Get.width,
                color: Colors.grey.shade300.withValues(alpha: 0.5),
                padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Text(
                  "Need help?",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              _buildHelpTile(title: "Passenger lost an item"),
              _buildHelpTile(title: "Passenger was rude"),
              _buildHelpTile(title: "Security Issues"),
              _buildHelpTile(title: "Passenger didn’t arrive"),
              SizedBox(height: Get.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildHelpTile({required String title}) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 30,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
        ),
        Divider(),
      ],
    );
  }

  Column _buildTripInfoDetails() {
    return Column(
      children: [
        _buildTile(title: "Distance", value: "2.5km"),
        _buildTile(title: "Ride duration", value: "22 min"),
        _buildTile(title: "Vehicle type", value: "Toyota Innova"),
        _buildTile(title: "Total fare", value: "₦2,500"),
      ],
    );
  }

  Widget _buildTile({required String title, required String value}) {
    return ListTile(
      minTileHeight: 30,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: Text(
        value,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: Get.width,
      color: Colors.grey.shade300.withValues(alpha: 0.5),
      alignment: Alignment.center,
      child: Text(
        "Ride Completed",
        style: GoogleFonts.manrope(
          color: Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "Ride Details",
        style: Get.textTheme.bodyMedium!.copyWith(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: 30,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}

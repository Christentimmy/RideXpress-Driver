import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class RateDriverScreen extends StatelessWidget {
  final RideModel rideModel;
  RateDriverScreen({super.key, required this.rideModel});

  final userController = Get.find<UserController>();
  final commentController = TextEditingController();
  final RxDouble value = 3.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Ride Finished",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            _buildTripInfo(),
            SizedBox(height: Get.height * 0.03),
            Center(
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      rideModel.riderModel?.avatar ?? "",
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "${rideModel.riderModel?.firstName} ${rideModel.riderModel?.lastName}",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                "Rate your rider",
                textAlign: TextAlign.center,
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            Center(
              child: Obx(
                () => RatingStars(
                  value: value.value,
                  onValueChanged: (v) {
                    value.value = v;
                  },
                  starCount: 5,
                  starSize: 30,
                  maxValue: 5,
                  starSpacing: 2,
                  animationDuration: Duration(milliseconds: 1000),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.yellow,
                  valueLabelVisibility: false,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.07),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: commentController,
                bgColor: Color(0xFFF8F8F8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                minLines: 5,
                maxLines: 6,
                hintText: "Leave a review about your experience",
              ),
            ),

            SizedBox(height: Get.height * 0.02),
            Center(
              child: CustomButton(
                width: Get.width * 0.75,
                borderRadius: BorderRadius.circular(20),
                ontap: () async {
                  if (rideModel.id == null) return;
                  userController.rateTrip(
                    rating: value.value.toString(),
                    comment: commentController.text,
                    rideId: rideModel.id!,
                  );
                },
                isLoading: userController.isloading,
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripInfo() {
    return Container(
      width: Get.width,
      color: Color(0xFFFFF5DC),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          ListTile(
            minTileHeight: 45,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on, color: Colors.green),
            title: Text(
              rideModel.pickupLocation?.address ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            minTileHeight: 45,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.location_on, color: Colors.orange),
            title: Text(
              rideModel.dropOffLocation?.address ?? "",
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

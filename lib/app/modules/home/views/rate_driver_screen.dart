import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class RateDriverScreen extends StatelessWidget {
  const RateDriverScreen({super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTripInfo(),
            SizedBox(height: Get.height * 0.1),
            Center(
              child: CircleAvatar(
                radius: 53,
                backgroundColor: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/ai.jpg"),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: Text(
                "Joshua Tobi",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Icon(
                    Icons.star,
                    color: AppColors.primaryColor,
                    size: 35,
                  ),
                );
              }),
            ),
            SizedBox(height: Get.height * 0.07),
            Center(
              child: CustomButton(
                width: Get.width * 0.75 ,
                borderRadius: BorderRadius.circular(20),
                ontap: () {
                  Get.offAllNamed(AppRoutes.homeScreen);
                },
                isLoading: false.obs,
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

  Container _buildTripInfo() {
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
              "Ikeja City Mall, Alausa Road, Ikeja",
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
            contentPadding: EdgeInsets.zero,
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
        ],
      ),
    );
  }
}

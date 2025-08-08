import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class SelectVehicleScreen extends StatelessWidget {
  SelectVehicleScreen({super.key});

  final List allVehicles = [
    {"title": "Saloon", "image": "assets/images/saloon.png"},
    {"title": "5 Seats", "image": "assets/images/saloon.png"},
    {"title": "6 Seats", "image": "assets/images/saloon.png"},
    {"title": "7 Seats", "image": "assets/images/saloon.png"},
    {"title": "8 Seats", "image": "assets/images/saloon.png"},
    {
      "title": "Wheelchair accessible",
      "image": "assets/images/wheelchair1.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Vehicle Type",
                  style: Get.textTheme.bodyMedium?.copyWith(
                    fontSize: 22,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Kindly select all the vehicle types\nthat applies to your Hackney\nCarriage.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(color: Color(0xFF898A8D)),
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: allVehicles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 1, color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(allVehicles[index]["image"]),
                        SizedBox(height: 10),
                        Text(
                          allVehicles[index]["title"],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.manrope(
                            color: Color(0xFF555555),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: Get.height * 0.13),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.manrope(
                          color: AppColors.primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

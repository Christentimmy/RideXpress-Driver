import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class VehicleDetailsScreen extends StatelessWidget {
  VehicleDetailsScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  final vehicleRegistrationNumberController = TextEditingController();
  final vehiclePlateNumberController = TextEditingController();
  final vehicleColorController = TextEditingController();
  // final vehicleMakeController = TextEditingController();
  final vehicleModelController = TextEditingController();
  final vehicleYearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: Get.height * 0.05),
            _buildFormFields(),
          ],
        ),
      ),
    );
  }

  Form _buildFormFields() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CustomTextField(
              controller: vehicleRegistrationNumberController,
              hintText: "Vehicle Registration Number",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: vehicleColorController,
              hintText: "Vehicle Color",
            ),
            // SizedBox(height: Get.height * 0.02),
            // CustomTextField(
            //   controller: vehicleMakeController,
            //   hintText: "Enter Vehicle Make",
            // ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: vehicleModelController,
              hintText: "Enter Vehicle Model",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: vehiclePlateNumberController,
              hintText: "Licensed Plate Number",
            ),
            SizedBox(height: Get.height * 0.02),
            CustomTextField(
              controller: vehicleYearController,
              hintText: "Enter Vehicle Year",
            ),
            SizedBox(height: Get.height * 0.03),
            CustomButton(
              isLoading: userController.isloading,
              child: Text(
                "Save",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              ontap: () async {
                if (!formKey.currentState!.validate()) return;
                if (userController.isloading.value) return;

                final driverProfile = DriverProfile(
                  vehicleRegNumber: vehicleRegistrationNumberController.text,
                  carColor: vehicleColorController.text,
                  carModel: vehicleModelController.text,
                  carPlate: vehiclePlateNumberController.text,
                  vehicleYear: vehicleYearController.text,
                );

                await userController.registerVehicleDetails(
                  driverProfile: driverProfile,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader() {
    return Container(
      color: Color(0xFFFFF5DC),
      height: Get.height * 0.33,
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Get.height * 0.08),
            Icon(Icons.arrow_back),

            SizedBox(height: Get.height * 0.02),
            Center(
              child: Text(
                "Vehicle Details",
                style: GoogleFonts.manrope(
                  fontSize: 22,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                "Kindly provide the details of your\nvehicle below to begin the\nregistration process",
                textAlign: TextAlign.center,
                style: GoogleFonts.manrope(
                  color: Color(0xFF898A8D),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

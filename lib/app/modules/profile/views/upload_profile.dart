import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/utils/image_picker.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class UploadProfile extends StatelessWidget {
  UploadProfile({super.key});

  final selectedFile = Rx<File?>(null);
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: [
          Center(
            child: Text(
              "Profile Picture",
              style: Get.textTheme.bodyMedium?.copyWith(
                fontSize: 22,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              "Upload a profile picture for\nyour new account",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(color: Color(0xFF898A8D)),
            ),
          ),
          SizedBox(height: Get.height * 0.1),
          _buildStackImage(),
          SizedBox(height: 15),
          Center(
            child: Text(
              "Choose from library",
              textAlign: TextAlign.center,
              style: GoogleFonts.manrope(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          SizedBox(height: Get.height * 0.33),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // TextButton(
                //   onPressed: () {
                //     Get.toNamed(AppRoutes.selectVehicle);
                //   },
                //   child: Text(
                //     "Skip",
                //     style: GoogleFonts.manrope(
                //       color: AppColors.primaryColor,
                //       fontSize: 15,
                //       fontWeight: FontWeight.w300,
                //     ),
                //   ),
                // ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    if (selectedFile.value == null) {
                      CustomSnackbar.showErrorToast("Please select an image");
                      return;
                    }
                    if (userController.isloading.value) return;
                    await userController.uploadProfilePicture(
                      imageFile: selectedFile.value!,
                    );
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.primaryColor,
                    child: Obx(
                      () => userController.isloading.value
                          ? const CupertinoActivityIndicator(color: Colors.white)
                          : Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stack _buildStackImage() {
    return Stack(
      children: [
        Obx(() {
          if (selectedFile.value != null) {
            return CircleAvatar(
              radius: 70,
              backgroundColor: Color.fromARGB(255, 255, 225, 135),
              backgroundImage: FileImage(selectedFile.value!),
            );
          }
          return CircleAvatar(
            radius: 70,
            backgroundColor: Color.fromARGB(255, 255, 225, 135),
            child: Icon(Icons.person, size: 60, color: Colors.white),
          );
        }),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: () async {
              final im = await pickImage();
              if (im == null) return;
              selectedFile.value = im;
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primaryColor,
              child: Icon(Icons.camera_alt_outlined, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/utils/image_picker.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';
import 'dart:io';
import 'package:ridexpressdriver/app/controller/user_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final userController = Get.find<UserController>();
  final Rx<File?> imageFile = Rx<File?>(null);

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              SizedBox(height: Get.height * 0.03),
              _buildImageAvater(),
              SizedBox(height: Get.height * 0.05),
              // Text(
              //   "First Name",
              //   style: GoogleFonts.poppins(
              //     fontSize: 13,
              //     color: Colors.grey.shade400,
              //     fontWeight: FontWeight.normal,
              //   ),
              // ),
              CustomTextField(
                hintText: "First Name",
                controller: firstNameController,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              CustomTextField(
                hintText: "Last Name",
                controller: lastNameController,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              CustomTextField(
                hintText: "Email",
                controller: emailController,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                // suffixIcon: FontAwesomeIcons.circleCheck,
                // suffixIconcolor: Colors.green,
              ),
              SizedBox(height: Get.height * 0.02),
              CustomTextField(
                hintText: "Phone Number",
                controller: phoneNumberController,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primaryColor),
                ),
                // suffixIcon: FontAwesomeIcons.circleXmark,
                // suffixIconcolor: Colors.red,
              ),
              SizedBox(height: Get.height * 0.1),
              CustomButton(
                isLoading: userController.isloading,
                ontap: () async {
                  if (userController.isloading.value) return;
                  UserModel userModel = UserModel();
                  if (firstNameController.text.isNotEmpty) {
                    userModel.firstName = firstNameController.text;
                  }
                  if (lastNameController.text.isNotEmpty) {
                    userModel.lastName = lastNameController.text;
                  }
                  if (emailController.text.isNotEmpty) {
                    userModel.email = emailController.text;
                  }
                  if (phoneNumberController.text.isNotEmpty) {
                    userModel.phone = phoneNumberController.text;
                  }
                  await userController.editProfile(
                    userModel: userModel,
                    file: imageFile.value,
                  );
                },
                child: Text(
                  "Save",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageAvater() {
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: Obx(() {
              if (imageFile.value != null) {
                return CircleAvatar(
                  radius: 45,
                  backgroundImage: FileImage(imageFile.value!),
                );
              }
              if (userController.userModel.value?.avatar != null) {
                return CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    userController.userModel.value!.avatar!,
                  ),
                );
              }
              return CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage("assets/images/placeholder.png"),
              );
            }),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                final im = await pickImage();
                if (im == null) return;
                imageFile.value = im;
              },
              child: CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

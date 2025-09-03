import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/auth_controller.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final authController = Get.find<AuthController>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: Get.textTheme.bodyMedium!.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SizedBox(height: Get.height * 0.03),
              // Text(
              //   "Current Password",
              //   style: Get.textTheme.bodyMedium!.copyWith(
              //     fontSize: 17,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: "Current Password",
                      controller: currentPasswordController,
                      prefixIcon: Icons.lock,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    CustomTextField(
                      hintText: "New Password",
                      controller: newPasswordController,
                      prefixIcon: Icons.lock,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.02),
                    CustomTextField(
                      hintText: "Confirm Password",
                      controller: confirmPasswordController,
                      prefixIcon: Icons.lock,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        if (value != newPasswordController.text) {
                          return "Password does not match";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: Get.height * 0.2),
              CustomButton(
                isLoading: authController.isLoading,
                child: Text(
                  "Save",
                  style: Get.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
                ontap: () async {
                  if (!formKey.currentState!.validate()) return;
                  await authController.changePassword(
                    newPassword: newPasswordController.text,
                    oldPassword: currentPasswordController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

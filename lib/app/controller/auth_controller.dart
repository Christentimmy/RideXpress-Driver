import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/data/services/auth_service.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class AuthController extends GetxController {
  final _authService = AuthService();
  final RxBool isLoading = false.obs;
  final RxBool isOtpVerifyLoading = false.obs;

  Future<void> driverRegister({required UserModel userModel}) async {
    isLoading.value = true;
    try {
      final response = await _authService.driverRegister(userModel: userModel);
      if (response == null) return;
      final decoded = json.decode(response.body);

      String message = decoded["message"] ?? "";
      if (response.statusCode != 201) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      final storageController = Get.find<StorageController>();
      final token = decoded["token"];
      await storageController.storeToken(token);

      await Get.find<UserController>().getUserDetails();

      Get.toNamed(AppRoutes.otpScreen, arguments: {"email": userModel.email});
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendOtp({required String email}) async {
    isLoading.value = true;
    try {
      final response = await _authService.sendOtp(email: email);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast("Failed to get OTP, $message");
        return;
      }
      CustomSnackbar.showSuccessToast("OTP sent successfully");
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp({
    required String otpCode,
    String? email,
    String? phoneNumber,
    VoidCallback? whatNext,
  }) async {
    isOtpVerifyLoading.value = true;
    try {
      final response = await _authService.verifyOtp(
        otpCode: otpCode,
        email: email,
        phoneNumber: phoneNumber,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }

      if (whatNext != null) {
        whatNext();
        return;
      }
      Get.toNamed(AppRoutes.uploadProfile);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isOtpVerifyLoading.value = false;
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    try {
      final response = await _authService.login(
        email: email,
        password: password,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      String userEmail = decoded["email"] ?? "";
      final storageController = Get.find<StorageController>();
      final token = decoded["token"] ?? "";
      await storageController.storeToken(token);

      if (response.statusCode == 402) {
        await sendOtp(email: userEmail);
        Get.toNamed(
          AppRoutes.otpScreen,
          arguments: {
            "email": userEmail,
            "whatNext": () {
              Get.toNamed(AppRoutes.bottomNavigationWidget);
            },
          },
        );
        return;
      }
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await Get.find<UserController>().getUserDetails();

      Get.toNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      final storageController = Get.find<StorageController>();
      await storageController.deleteToken();
      Get.find<UserController>().clean();
      final token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _authService.logout(token: token);
      if (response == null) return;
      if (response.statusCode != 200) return;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

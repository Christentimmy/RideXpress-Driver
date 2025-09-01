import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/data/services/user_service.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class UserController extends GetxController {
  final isloading = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final _userService = UserService();

  Future<void> getUserDetails() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getUserDetails(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        debugPrint(message);
        return;
      }

      final user = decoded["data"] ?? [];
      if (user == null) return;
      final mappedUser = UserModel.fromJson(user);
      userModel.value = mappedUser;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> uploadProfilePicture({required File imageFile}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.uploadProfilePicture(
        token: token,
        imageFile: imageFile,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.toNamed(AppRoutes.selectVehicle);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> registerCarType({
    required bool wheelChairAccessible,
    required int seats,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.registerCarType(
        token: token,
        wheelChairAccessible: wheelChairAccessible,
        seats: seats,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.toNamed(AppRoutes.vehicleDetails);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> registerVehicleDetails({
    required DriverProfile driverProfile,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.registerVehicleDetails(
        token: token,
        driverProfile: driverProfile,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.toNamed(AppRoutes.submitDocuments);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> uplaodDocuments({
    required File driverLicensePath,
    required File vehicleLicensePath,
    required File vehicleInsurancePath,
    required File motCertificatePath,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.uplaodDocuments(
        token: token,
        driverLicensePath: driverLicensePath,
        vehicleLicensePath: vehicleLicensePath,
        vehicleInsurancePath: vehicleInsurancePath,
        motCertificatePath: motCertificatePath,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/auth_controller.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/data/services/user_service.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class UserController extends GetxController {
  final isloading = false.obs;
  final rideRequestLoading = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final _userService = UserService();
  final rideRequestList = <RideModel>[].obs;

  //ride
  final isRequestloading = false.obs;
  final Rxn<RideModel> currentRide = Rxn<RideModel>(null);
  final RxString rideStatus = "".obs;
  Rxn<UserModel> detectedDriver = Rxn<UserModel>();
  RxString estimatedArrivalTime = "".obs;
  RxString estimatedDistance = "".obs;
  final RxList<RideModel> rideHistory = <RideModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetails();
  }

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

  Future<void> updateOnlineStatus({required String status}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.updateOnlineStatus(
        token: token,
        status: status,
      );
      if (response == null) return;
      if (response.statusCode != 200) return;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<bool> getUserStatus() async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        Get.toNamed(AppRoutes.loginScreen);
        return true;
      }

      final response = await _userService.getUserStatus(token: token);
      if (response == null) {
        Get.toNamed(AppRoutes.loginScreen);
        return true;
      }
      final decoded = json.decode(response.body);

      if (response.statusCode != 200) {
        Get.toNamed(AppRoutes.loginScreen);
        return true;
      }
      final userData = decoded["data"];
      if (userData == null) {
        Get.toNamed(AppRoutes.loginScreen);
        return true;
      }
      String status = userData["status"] ?? "";
      String email = userData["email"] ?? "";

      if (status != "active") {
        Get.toNamed(AppRoutes.loginScreen);
        CustomSnackbar.showErrorToast("Account $status");
        return true;
      }

      bool isEmailVerified = userData["is_email_verified"] ?? false;

      if (isEmailVerified != true) {
        await Get.find<AuthController>().sendOtp(email: email);
        Get.toNamed(
          AppRoutes.otpScreen,
          arguments: {
            "email": email,
            "whatNext": () async {
              await getUserStatus();
              // Get.toNamed(AppRoutes.bottomNavigationWidget);
            },
          },
        );
        CustomSnackbar.showErrorToast("Email not verified");
        return true;
      }

      bool profileCompleted = userData["profile_completed"] ?? false;
      String role = userData["role"] ?? "";
      if (role == "driver" && !profileCompleted) {
        Get.toNamed(AppRoutes.uploadProfile);
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
    return false;
  }

  Future<void> getRideRequest() async {
    rideRequestLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.getRideRequest(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List rideRequest = decoded["data"] ?? [];
      if (rideRequest.isEmpty) return;

      List<RideModel> mappedRideRequest = rideRequest
          .map((x) => RideModel.fromJson(x))
          .toList();
      rideRequestList.value = mappedRideRequest;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      rideRequestLoading.value = false;
    }
  }

  Future<void> updateLocation({required LocationModel location}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.updateLocation(
        token: token,
        location: location,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  void clean() {
    rideRequestList.value = [];
    rideRequestLoading.value = false;
    isloading.value = false;
    userModel.value = null;
  }
}

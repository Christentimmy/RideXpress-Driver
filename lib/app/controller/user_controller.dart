import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/auth_controller.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/data/models/message_model.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/data/services/user_service.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class UserController extends GetxController {
  final isloading = false.obs;
  final isAcceptLoading = false.obs;
  final isDeclineLoading = false.obs;
  final rideRequestLoading = false.obs;
  Rxn<UserModel> userModel = Rxn<UserModel>();
  final _userService = UserService();
  final rideRequestList = <RideModel>[].obs;

  //ride
  final totalRidesToday = 0.obs;
  final totalRides = 0.obs;
  final isRequestloading = false.obs;
  final RxList<RideModel> rideHistory = <RideModel>[].obs;

  //pagination
  final RxInt currentPage = 1.obs;
  final RxBool hasMorePage = false.obs;

  //chat
  RxList<MessageModel> chatHistoryAndLiveMessage = <MessageModel>[].obs;

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

  Future<void> acceptRide({required String rideId}) async {
    isAcceptLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.acceptRide(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final rideModel = RideModel.fromJson(decoded["data"]);
      Get.toNamed(
        AppRoutes.tripStatusScreen,
        arguments: {"rideModel": rideModel},
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isAcceptLoading.value = false;
    }
  }

  Future<void> declineRide({required String rideId}) async {
    isDeclineLoading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.declineRide(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
      rideRequestList.removeWhere((element) => element.id == rideId);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isDeclineLoading.value = false;
    }
  }

  Future<void> arrivedAtPickUp({
    required String rideId,
    required RxString status,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.arrivedAtPickUp(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      status.value = "arrived";
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getCurrentRide() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        Get.toNamed(AppRoutes.loginScreen);
        return;
      }

      final response = await _userService.getCurrentRide(token: token);
      if (response == null) {
        Get.toNamed(AppRoutes.bottomNavigationWidget);
        return;
      }
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) {
        Get.toNamed(AppRoutes.bottomNavigationWidget);
        return;
      }
      final data = decoded["data"];
      if (data == null) {
        Get.toNamed(AppRoutes.bottomNavigationWidget);
        return;
      }
      final ride = data["ride"];
      if (ride == null) {
        Get.toNamed(AppRoutes.bottomNavigationWidget);
        return;
      }
      print("Ride current status: ${ride["status"]}");
      final mappedRide = RideModel.fromJson(ride);
      if (mappedRide.status?.value == "completed") {
        Get.toNamed(
          AppRoutes.rateDriverScreen,
          arguments: {"rideModel": mappedRide},
        );
        return;
      }
      Map<String, dynamic> arguments = {"rideModel": mappedRide};
      Get.toNamed(AppRoutes.tripStatusScreen, arguments: arguments);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> startUp({
    required String rideId,
    required RxString status,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.startUp(token: token, rideId: rideId);
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      status.value = "progress";
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> completeRide({required String rideId}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.completeRide(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final rideModel = RideModel.fromJson(decoded["data"]);
      Get.toNamed(
        AppRoutes.rateDriverScreen,
        arguments: {"rideModel": rideModel},
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> rateTrip({
    required String rating,
    required String comment,
    required String rideId,
  }) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.rateTrip(
        token: token,
        rating: rating,
        comment: comment,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      await getRideRequest();
      CustomSnackbar.showSuccessToast(message);
      Get.offAllNamed(AppRoutes.bottomNavigationWidget);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> cancelRide({required String rideId}) async {
    isRequestloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) return;

      final response = await _userService.cancelRide(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      final message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      CustomSnackbar.showSuccessToast(message);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRequestloading.value = false;
    }
  }

  Future<void> getRideHistory({
    bool showLoader = true,
    bool isMore = false,
    String? status,
    String? timeRange,
  }) async {
    isloading.value = showLoader;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        Get.toNamed(AppRoutes.loginScreen);
        return;
      }

      if (isMore) {
        currentPage.value++;
      }
      if (status != null && status == "All") {
        status = "";
      }

      final response = await _userService.getRideHistory(
        token: token,
        page: currentPage.value,
        status: status?.toLowerCase(),
        timeRange: timeRange?.toLowerCase(),
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      if (response.statusCode != 200) return;
      List resData = decoded["data"] ?? [];
      final hasMore = decoded["pagination"]?["hasMore"] ?? false;
      hasMorePage.value = hasMore;
      if (isMore) {
        rideHistory.addAll(resData.map((e) => RideModel.fromJson(e)));
      } else {
        rideHistory.value = resData.map((e) => RideModel.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getMessageHistory({required String rideId}) async {
    isloading.value = true;
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }

      final response = await _userService.getMessageHistory(
        token: token,
        rideId: rideId,
      );
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      List chatHistory = decoded["data"] ?? [];
      chatHistoryAndLiveMessage.clear();
      if (chatHistory.isEmpty) return;
      List<MessageModel> mapped = chatHistory
          .map((json) => MessageModel.fromJson(json))
          .toList();
      chatHistoryAndLiveMessage.assignAll(mapped);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isloading.value = false;
    }
  }

  Future<void> getTodayRideSummary() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }

      final response = await _userService.getTodayRideSummary(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final stats = decoded["data"];
      if (stats == null) return;
      totalRidesToday.value = stats["totalRides"];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getDriverRideStat() async {
    try {
      final storageController = Get.find<StorageController>();
      String? token = await storageController.getToken();
      if (token == null || token.isEmpty) {
        CustomSnackbar.showErrorToast("Authentication required");
        return;
      }

      final response = await _userService.getDriverRideStat(token: token);
      if (response == null) return;
      final decoded = json.decode(response.body);
      String message = decoded["message"] ?? "";
      if (response.statusCode != 200) {
        CustomSnackbar.showErrorToast(message);
        return;
      }
      final stats = decoded["data"];
      if (stats == null) return;
      totalRides.value = stats["allTripCounts"];
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void clean() {
    rideRequestList.value = [];
    rideRequestLoading.value = false;
    isloading.value = false;
    userModel.value = null;
  }
}

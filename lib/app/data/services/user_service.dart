import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/utils/base_url.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class UserService {
  final http.Client client = http.Client();

  Future<http.Response?> saveUserOneSignalId({
    required String token,
    required String id,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/save-signal-id/$id"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getUserDetails({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-details"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> uploadProfilePicture({
    required String token,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse("$baseUrl/user/upload-profile");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..headers['Content-Type'] = 'multipart/form-data'
        ..files.add(
          await http.MultipartFile.fromPath('avatar', imageFile.path),
        );

      var response = await request.send().timeout(const Duration(seconds: 60));
      return await http.Response.fromStream(response);
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> registerCarType({
    required String token,
    required bool wheelChairAccessible,
    required int seats,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/register-car-type"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({
              "wheelChairAccessible": wheelChairAccessible,
              "seats": seats,
            }),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> registerVehicleDetails({
    required String token,
    required DriverProfile driverProfile,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/register-vehicle"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode(driverProfile.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> uplaodDocuments({
    required String token,
    required File driverLicensePath,
    required File vehicleLicensePath,
    required File vehicleInsurancePath,
    required File motCertificatePath,
  }) async {
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$baseUrl/user/upload-vehicle-docs'),
      );

      request.headers.addAll({'Authorization': 'Bearer $token'});

      request.files.add(
        await http.MultipartFile.fromPath(
          'driver_license',
          driverLicensePath.path,
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'vehicle_license',
          vehicleLicensePath.path,
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'vehicle_insurance',
          vehicleInsurancePath.path,
        ),
      );
      request.files.add(
        await http.MultipartFile.fromPath(
          'mot_certificate',
          motCertificatePath.path,
        ),
      );

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 120),
      );
      final response = await http.Response.fromStream(streamedResponse);

      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateOnlineStatus({
    required String token,
    required String status,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/update-availability-status"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"status": status}),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getUserStatus({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/get-user-status"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 5));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getRideRequest({required String token}) async {
    try {
      final response = await client
          .get(
            Uri.parse("$baseUrl/user/driver-ride-requests"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> updateLocation({
    required String token,
    required LocationModel location,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/update-location"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode(location.toJson()),
          )
          .timeout(const Duration(seconds: 30));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> acceptRide({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/accept-ride"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> arrivedAtPickUp({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/arrived-at-pickup-location"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getCurrentRide({required String token}) async {
    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/user/get-current-ride"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error currrent ride: $e");
    }
    return null;
  }

  Future<http.Response?> startUp({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/start-ride"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> completeRide({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/complete-ride"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> rateTrip({
    required String token,
    required String rating,
    required String comment,
    required String rideId,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/rate-trip"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              "rating": rating,
              "comment": comment,
              "rideId": rideId,
            }),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error rate ride: $e");
    }
    return null;
  }

  Future<http.Response?> cancelRide({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/cancel-ride"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error cancelling ride: $e");
    }
    return null;
  }

  Future<http.Response?> declineRide({
    required String token,
    required String rideId,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user/decline-ride"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({"rideId": rideId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error declining ride: $e");
    }
    return null;
  }

  Future<http.Response?> getRideHistory({
    required String token,
    required int page,
    String? status,
    String? timeRange,
  }) async {
    try {
      Uri url = Uri.parse("$baseUrl/user/get-ride-history").replace(
        queryParameters: {
          "page": page.toString(),
          if (status != null) "status": status,
          if (timeRange != null) "timeRange": timeRange,
        },
      );

      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint("❌ Error get ride history: $e");
    }
    return null;
  }

  Future<http.Response?> getMessageHistory({
    required String token,
    required String rideId,
  }) async {
    try {
      http.Response response = await client
          .get(
            Uri.parse("$baseUrl/message/history/$rideId"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection");
      debugPrint("No internet connection $e");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }

  Future<http.Response?> getTodayRideSummary({required String token}) async {
    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/user/get-today-ride-summary"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection");
      debugPrint("No internet connection $e");
      return null;
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably bad network, try again",
      );
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }

  Future<http.Response?> getDriverRideStat({required String token}) async {
    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/user/get-driver-ride-stat"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
      return null;
    } on TimeoutException {
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }

  Future<http.Response?> editProfile({
    required String token,
    File? file,
    UserModel? userModel,
  }) async {
    try {
      final uri = Uri.parse("$baseUrl/user/edit-profile");
      final request = http.MultipartRequest('POST', uri);
      request.headers.addAll(({"Authorization": "Bearer $token"}));
      if (file != null) {
        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        final mimeSplit = mimeType.split('/');
        request.files.add(
          await http.MultipartFile.fromPath(
            'avatar',
            file.path,
            contentType: MediaType(mimeSplit[0], mimeSplit[1]),
          ),
        );
      }
      if (userModel != null) {
        request.fields.addAll(
          userModel.toJson().map(
            (key, value) => MapEntry(key, value.toString()),
          ),
        );
      }
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 60),
      );
      return await http.Response.fromStream(streamedResponse);
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> getAllRatings({required String token}) async {
    try {
      final response = await http
          .get(
            Uri.parse("$baseUrl/user/get-rating"),
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
      return null;
    } on TimeoutException {
      debugPrint("Request timeout");
      return null;
    } catch (e) {
      throw Exception("Unexpected error $e");
    }
  }

  Future<http.Response?> call({
    required String token,
    required String tripId,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/user/call"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
            body: jsonEncode({"tripId": tripId}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } on SocketException catch (e) {
      debugPrint("No internet connection $e");
    } on TimeoutException {
      debugPrint("Request timeout");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}


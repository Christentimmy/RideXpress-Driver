import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/utils/base_url.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class AuthService {
  http.Client client = http.Client();

  Future<http.Response?> driverRegister({required UserModel userModel}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/driver-register"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(userModel.toJson()),
          )
          .timeout(const Duration(seconds: 60));
      return response;
    } on SocketException catch (e) {
      CustomSnackbar.showErrorToast("Check internet connection");
      debugPrint("SocketException: $e");
    } on TimeoutException {
      CustomSnackbar.showErrorToast(
        "Request timeout, probably Bad network, try again",
      );
      debugPrint("Request Time out");
    } catch (e) {
      debugPrint("Error From Auth Servie: ${e.toString()}");
    }
    return null;
  }

  Future<http.Response?> sendOtp({required String email}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/send-otp"),
            headers: {"Content-Type": "application/json"},
            body: json.encode({"email": email}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  Future<http.Response?> verifyOtp({
    required String otpCode,
    String? email,
    String? phoneNumber,
  }) async {
    try {
      final Map<String, String> body = {"otp": otpCode};

      if (email?.isNotEmpty == true) {
        body["email"] = email!;
      }

      if (phoneNumber?.isNotEmpty == true) {
        body["phone_number"] = phoneNumber!;
      }

      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/verify-otp"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<http.Response?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"identifier": email, "password": password}),
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<http.Response?> logout({required String token}) async {
    try {
      final response = await client
          .post(
            Uri.parse("$baseUrl/auth/logout"),
            headers: {
              "Authorization": "Bearer $token",
              "Content-Type": "application/json",
            },
          )
          .timeout(const Duration(seconds: 15));
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

}

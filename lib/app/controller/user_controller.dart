import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:ridexpressdriver/app/data/services/user_service.dart';

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
}

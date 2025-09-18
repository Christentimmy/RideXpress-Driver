import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class TaxiCallPage extends StatelessWidget {
  final String callID; // unique per trip (like tripId)

  TaxiCallPage({super.key, required this.callID});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 0, // from ZEGOCLOUD console
      appSign: "", // from ZEGOCLOUD console
      userID: userController.userModel.value?.id ?? "",
      userName: userController.userModel.value?.firstName ?? "",
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}

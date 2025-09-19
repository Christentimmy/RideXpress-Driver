import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatelessWidget {
  final String callID; 

  CallScreen({super.key, required this.callID});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1008736088, 
      appSign: "f3951f9c7db8d9198995aeb8d8b3d2e12ea30a43e0b8474b9dcc690db34c61ce",
      userID: userController.userModel.value?.id ?? "",
      userName: userController.userModel.value?.firstName ?? "",
      callID: callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
    );
  }
}

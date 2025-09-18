import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class TaxiCallPage extends StatelessWidget {
  final String userID; // could be driverId or passengerId
  final String userName;
  final String callID; // unique per trip (like tripId)

  const TaxiCallPage({
    super.key,
    required this.userID,
    required this.userName,
    required this.callID,
  });

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 0, // from ZEGOCLOUD console
      appSign: "", // from ZEGOCLOUD console
      userID: userID,
      userName: userName,
      callID: callID, // tripId as callId
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
      // config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
      //   ..onOnlySelfInRoom = (context) {
      //     Navigator.of(context).pop(); // End call if the other leaves
      //   },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketController extends GetxController with WidgetsBindingObserver {
  io.Socket? socket;
  int _reconnectAttempts = 0;
  final int _maxReconnectAttempts = 5;
  RxBool isloading = false.obs;
  final userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> initializeSocket() async {
    String? token = await StorageController().getToken();
    if (token == null) {
      return;
    }

    socket = io.io("https://774ba98dfbe0.ngrok-free.app", <String, dynamic>{
      'transports': ['websocket'],
      'extraHeaders': {'Authorization': 'Bearer $token'},
      'reconnection': true,
      "forceNew": true,
    });

    socket?.connect();

    socket?.onConnect((_) {
      print("Socket connected successfully");
      listenToEvents();
    });

    socket?.onDisconnect((_) {
      print("Socket disconnected");
      scheduleReconnect();
      if (_reconnectAttempts >= _maxReconnectAttempts) {
        // disConnectListeners();
      }
    });

    socket?.on('connect_error', (_) {
      print("Connection error");
      scheduleReconnect();
    });
  }

  void listenToEvents() {
    socket?.on("tripStatus", (data) async {
      String status = data["data"]?["status"] ?? "";
      final ride = data["data"]?["ride"];
      final driver = data["data"]?["driver"];

      userController.rideStatus.value = status;
      final rideData = RideModel.fromJson(ride);
      userController.currentRide.value = rideData;

      if (status == "accepted" && driver != null) {
        final driverData = UserModel.fromJson(driver);
        userController.detectedDriver.value = driverData;

        final eta = data["data"]?["eta"];
        if (eta != null) {
          userController.estimatedArrivalTime.value = eta["minutes"].toString();
          userController.estimatedDistance.value = eta["distance_km"].toString();
        }
      }
    });
  }

  void scheduleReconnect() {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint("🚨 Max reconnection attempts reached. Stopping retry.");
      return;
    }

    int delay = 2 * _reconnectAttempts + 2;
    debugPrint("🔄 Reconnecting in $delay seconds...");

    Future.delayed(Duration(seconds: delay), () {
      _reconnectAttempts++;
      socket?.connect();
    });
  }
}

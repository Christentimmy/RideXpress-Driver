import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/message_model.dart';
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

    socket = io.io("https://6d08e5c95687.ngrok-free.app", <String, dynamic>{
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
    socket?.on("ride-request", (data) async {
      await Get.find<UserController>().getRideRequest();
    });

    socket?.on("receive-message", (data) {
      final message = Map<String, dynamic>.from(data);
      final messageModel = MessageModel.fromJson(message);
      final messageController = Get.find<UserController>();

      // Check if the message already exists to avoid duplicates
      final exists = messageController.chatHistoryAndLiveMessage.any(
        (msg) => msg.id == messageModel.id,
      );

      if (exists) return;
      final index = messageController.chatHistoryAndLiveMessage.indexWhere(
        (msg) => msg.clientGeneratedId == messageModel.clientGeneratedId,
      );
      if (index != -1) {
        messageController.chatHistoryAndLiveMessage[index].mediaUrl =
            messageModel.mediaUrl;
        messageController.chatHistoryAndLiveMessage[index].multipleImages =
            messageModel.multipleImages;
        messageController.chatHistoryAndLiveMessage[index].id = messageModel.id;
        messageController.chatHistoryAndLiveMessage[index].avater =
            messageModel.avater;
        messageController.chatHistoryAndLiveMessage[index].createdAt =
            messageModel.createdAt;
        messageController.chatHistoryAndLiveMessage.refresh();
      } else {
        messageController.chatHistoryAndLiveMessage.add(messageModel);
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

import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/auth_controller.dart';
import 'package:ridexpressdriver/app/controller/location_controller.dart';
import 'package:ridexpressdriver/app/controller/network_controller.dart';
import 'package:ridexpressdriver/app/controller/notification_controller.dart';
import 'package:ridexpressdriver/app/controller/socket_controller.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(StorageController());
    Get.put(AuthController());
    Get.put(UserController());
    Get.put(NetworkController());
    Get.put(SocketController());
    Get.put(LocationController());
    Get.put(NotificationController());
  }
}

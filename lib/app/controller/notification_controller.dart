import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:ridexpressdriver/app/controller/storage_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initOneSignal();
    // saveUserOneSignalId();

    OneSignal.Notifications.addClickListener((event) {
      final notification = event.notification;
      final data = notification.additionalData;
      final actionId = event.result.actionId;

      if (data?['type'] == 'call') {
        final tripId = data?["tripId"];
        if (actionId == 'accept') {
          Get.toNamed(AppRoutes.callScreen, arguments: {"tripId": tripId});
        } else if (actionId == 'decline') {}
      }
    });
  }

  Future<void> initOneSignal() async {
    OneSignal.initialize("2fa250e8-3569-45a5-9c27-db2be9b84c36");
    if (OneSignal.Notifications.permission == false) {
      await OneSignal.Notifications.requestPermission(true);
    }
  }

  Future<void> saveUserOneSignalId() async {
    final userController = Get.find<UserController>();
    final userId = userController.userModel.value?.id;
    final subId = OneSignal.User.pushSubscription.id;

    final storageController = Get.find<StorageController>();

    if (userId == null || subId == null) return;

    final lastSaved = await storageController.getLastPushId(userId);

    if (lastSaved == subId) {
      return;
    }

    await userController.saveOneSignalId(oneSignalId: subId);
  }
}

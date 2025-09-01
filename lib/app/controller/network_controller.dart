import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';

class NetworkController extends GetxController {
  final _connectivity = Connectivity();
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  final RxBool isOnline = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen(_onChanged);
  }

  Future<void> _initConnectivity() async {
    final results = await _connectivity.checkConnectivity();
    _updateOnline(results);
  }

  void _onChanged(List<ConnectivityResult> results) {
    _updateOnline(results);
  }

  void _updateOnline(List<ConnectivityResult> results) {
    // Connected if ANY interface is not 'none'
    final connected = results.any((r) => r != ConnectivityResult.none);

    if (connected != isOnline.value) {
      isOnline.value = connected;
      if (connected) {
        onConnected();
      } else {
        onDisconnected();
      }
    }
  }

  // ---- Hooks for your API calls ----
  Future<void> onConnected() async {
    final userController = Get.find<UserController>();
    await userController.updateOnlineStatus(status: "online");
  }

  Future<void> onDisconnected() async {
    final userController = Get.find<UserController>();
    await userController.updateOnlineStatus(status: "offline");
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}

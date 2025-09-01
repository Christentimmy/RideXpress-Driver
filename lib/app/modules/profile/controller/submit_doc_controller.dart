import 'dart:io';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class SubmitDocController extends GetxController {
  Rx<File?> driverLicensePath = Rx<File?>(null);
  Rx<File?> vehicleLicensePath = Rx<File?>(null);
  Rx<File?> vehicleInsurancePath = Rx<File?>(null);
  Rx<File?> motCertificatePath = Rx<File?>(null);

  Future<void> uploadDocuments() async {
    final userController = Get.find<UserController>();
    if (driverLicensePath.value == null) {
      CustomSnackbar.showErrorToast("Please upload driver's license");
      return;
    }
    if (vehicleLicensePath.value == null) {
      CustomSnackbar.showErrorToast("Please upload vehicle license");
      return;
    }
    if (vehicleInsurancePath.value == null) {
      CustomSnackbar.showErrorToast("Please upload vehicle insurance");
      return;
    }
    if (motCertificatePath.value == null) {
      CustomSnackbar.showErrorToast("Please upload MOT certificate");
      return;
    }
    await userController.uplaodDocuments(
      driverLicensePath: driverLicensePath.value!,
      vehicleLicensePath: vehicleLicensePath.value!,
      vehicleInsurancePath: vehicleInsurancePath.value!,
      motCertificatePath: motCertificatePath.value!,
    );
  }
}

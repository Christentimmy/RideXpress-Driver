import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/modules/profile/controller/submit_doc_controller.dart';
import 'package:ridexpressdriver/app/utils/image_picker.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';
import 'package:ridexpressdriver/app/widgets/snack_bar.dart';

class UploadDocumentScreen extends StatelessWidget {
  final String title;
  UploadDocumentScreen({super.key, required this.title});

  final selectedFile = Rx<File?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Color(0xFF555555),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Kindly keep the entire document inside\nthe frame",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.manrope(
                    color: Color(0xFF898A8D),
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final im = await pickImage();
                    if (im == null) return;
                    selectedFile.value = im;
                  },
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Obx(
                      () => selectedFile.value == null
                          ? Icon(Icons.image, size: 100, color: Colors.white)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Image.file(
                                selectedFile.value!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              CustomButton(
                height: 55,
                isLoading: false.obs,
                bgColor: Color(0xFF555555),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
                ontap: () {
                  if (selectedFile.value == null) {
                    CustomSnackbar.showErrorToast("Please select an image");
                    return;
                  }
                  final subDocController = Get.find<SubmitDocController>();
                  if (title.contains("Driver")) {
                    subDocController.driverLicensePath.value =
                        selectedFile.value;
                  }
                  if (title == "HC - Vehicle Licence") {
                    subDocController.vehicleLicensePath.value =
                        selectedFile.value;
                  }
                  if (title == "Vehicle Insurance") {
                    subDocController.vehicleInsurancePath.value =
                        selectedFile.value;
                  }
                  if (title == "MOT Certificate") {
                    subDocController.motCertificatePath.value =
                        selectedFile.value;
                  }
                  Get.back();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Upload Picture",
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Get.back();
        },
      ),
      centerTitle: true,
      title: Text(
        title,
        style: GoogleFonts.manrope(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

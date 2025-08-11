import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/widgets/custom_button.dart';

class UploadDocumentScreen extends StatelessWidget {
  final String title;
  const UploadDocumentScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
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
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Icon(Icons.image, size: 100, color: Colors.white),
                ),
              ),
              CustomButton(
                width: Get.width * 0.55,
                height: 45,
                isLoading: false.obs,
                bgColor: Color(0xFF555555),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(25),
                ontap: () => Get.back(),
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
}

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/widgets/custom_textfield.dart';

class PhoneAuthenticationScreen extends StatelessWidget {
  const PhoneAuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        onPressed: () {
          Get.toNamed(AppRoutes.otpScreen);
        },
        backgroundColor: AppColors.primaryColor,
        elevation: 1,
        child: Icon(Icons.arrow_forward, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.1),
            Center(
              child: Text(
                'Authentication',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Text(
              'Enter your number below. A code\nwill be sent for verification.',
              style: Get.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Get.height * 0.1),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(15, 0, 0, 0),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (code) {},
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: false,
                    margin: EdgeInsets.only(right: 5),
                    padding: EdgeInsets.zero,
                    initialSelection: 'GB',
                    alignLeft: false,
                    searchStyle: Get.textTheme.bodyMedium,
                  ),
                  Expanded(
                    child: CustomTextField(
                      hintText: 'Phone Number',
                      keyboardType: TextInputType.phone,
                      contentPadding: EdgeInsets.zero,
                      controller: TextEditingController(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

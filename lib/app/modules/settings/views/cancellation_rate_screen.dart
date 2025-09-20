import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';

class CancellationRateScreen extends StatefulWidget {
  const CancellationRateScreen({super.key});

  @override
  State<CancellationRateScreen> createState() => _CancellationRateScreenState();
}

class _CancellationRateScreenState extends State<CancellationRateScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userController.getDriverRideStat();
      userController.getAllRatings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        title: Text(
          "Cancellation Rate",
          style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: Get.width,
              height: Get.height * 0.3,
              color: const Color.fromARGB(255, 247, 245, 245),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() {
                    return Text(
                      "${userController.cancellationRatePercentage.value}%",
                      style: GoogleFonts.manrope(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  Text(
                    "This Year",
                    style: GoogleFonts.manrope(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Trip requested",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Obx(() {
                    return Text(
                      "${userController.totalRides.value}",
                      style: GoogleFonts.manrope(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Divider(height: 50),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              horizontalTitleGap: 10,
              minTileHeight: 35,
              leading: Icon(Icons.check, color: Colors.green),
              title: Text(
                "Accepted",
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Obx(
                () => Text(
                  "${userController.acceptanceRatePercentage.value}",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              horizontalTitleGap: 10,
              minTileHeight: 35,
              leading: Icon(
                FontAwesomeIcons.xmark,
                size: 20,
                color: Colors.orange,
              ),
              title: Text(
                "Decline",
                style: GoogleFonts.manrope(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Obx(
                () => Text(
                  "${userController.cancellationRatePercentage.value}",
                  style: GoogleFonts.manrope(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

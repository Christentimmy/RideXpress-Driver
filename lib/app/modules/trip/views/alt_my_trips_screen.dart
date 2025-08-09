import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class AltMyTripsScreen extends StatelessWidget {
  AltMyTripsScreen({super.key});

  final RxInt selectedDate = (-1).obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'RIDES',
          style: Get.textTheme.bodyMedium!.copyWith(
            color: AppColors.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: AppColors.primaryColor),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    DateFormat('MMM yyyy').format(DateTime.now()),
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.primaryColor,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.keyboard_arrow_down_outlined),
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 59,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    DateTime date = DateTime.now().add(Duration(days: index));
                    return Obx(
                      () => InkWell(
                        onTap: () {
                          selectedDate.value = index;
                        },
                        child: Container(
                          width: 50,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: selectedDate.value == index
                                ? AppColors.primaryColor
                                : AppColors.primaryColor.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('E').format(date),
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: selectedDate.value == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              Text(
                                DateFormat('dd').format(date),
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: selectedDate.value == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              _buildTripCard(
                status: 'DRIVER DIDN’T SHOW UP',
                statusColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripCard({required String status, required Color statusColor}) {
    return InkWell(
      onTap: () {
        // Get.to(() => AltTripDetailsScreen());
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            ListTile(
              minTileHeight: 45,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text(
                "Ikeja City Mall, Alausa Road",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                "2:21pm",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            ListTile(
              minTileHeight: 45,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.orange),
              title: Text(
                "Shoprite Event Centre, Ikeja",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                "1:21pm",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/ai.jpg"),
              ),
              title: Text(
                "Joshua Tobi",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              subtitle: Row(
                children: [
                  Icon(Icons.star, color: AppColors.primaryColor, size: 18),
                  SizedBox(width: 3),
                  Text(
                    "4.8",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "\$900",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "Ride Completed",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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

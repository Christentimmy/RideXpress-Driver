import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:ridexpressdriver/app/utils/loaders.dart';

class AltMyTripsScreen extends StatefulWidget {
  const AltMyTripsScreen({super.key});

  @override
  State<AltMyTripsScreen> createState() => _AltMyTripsScreenState();
}

class _AltMyTripsScreenState extends State<AltMyTripsScreen> {
  final RxInt selectedDate = (-1).obs;
  final scrollController = ScrollController();

  final userController = Get.find<UserController>();
  RxBool isLoadingMore = false.obs;

  RxString selectedStatus = 'All'.obs;
  RxString selectedTimeRange = 'All Time'.obs;

  final List<String> statusOptions = [
    'All',
    'Pending',
    'Completed',
    'Cancelled',
    "Panic",
  ];

  final List<String> timeRangeOptions = [
    'All Time',
    'Last 30 Days',
    'Last 3 Months',
    'This Year',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userController.rideHistory.isEmpty) {
        userController.getRideHistory();
      }
    });
    scrollController.addListener(() async {
      if (isLoadingMore.value) return;
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        isLoadingMore.value = true;
        await userController.getRideHistory(
          isMore: true,
          showLoader: false,
          status: selectedStatus.value,
          timeRange: selectedTimeRange.value,
        );
        isLoadingMore.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            color: AppColors.primaryColor,
            onRefresh: () async {
              userController.getRideHistory();
            },
            child: ListView(
              children: [
                Divider(color: AppColors.primaryColor),
                // SizedBox(height: 10),
                // Row(
                //   children: [
                //     Text(
                //       DateFormat('MMM yyyy').format(DateTime.now()),
                //       style: Get.textTheme.bodyMedium!.copyWith(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     IconButton(
                //       visualDensity: VisualDensity.compact,
                //       onPressed: () {
                //         showDatePicker(
                //           context: context,
                //           firstDate: DateTime.now(),
                //           lastDate: DateTime.now().add(
                //             const Duration(days: 365),
                //           ),
                //           initialDate: DateTime.now(),
                //           builder: (context, child) {
                //             return Theme(
                //               data: ThemeData(
                //                 colorScheme: ColorScheme.light(
                //                   primary: AppColors.primaryColor,
                //                 ),
                //               ),
                //               child: child!,
                //             );
                //           },
                //         );
                //       },
                //       icon: Icon(Icons.keyboard_arrow_down_outlined),
                //       color: AppColors.primaryColor,
                //     ),
                //   ],
                // ),
                // SizedBox(height: 10),
                // SizedBox(
                //   height: 59,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 10,
                //     itemBuilder: (context, index) {
                //       DateTime date = DateTime.now().add(Duration(days: index));
                //       return Obx(
                //         () => InkWell(
                //           onTap: () {
                //             selectedDate.value = index;
                //           },
                //           child: Container(
                //             width: 50,
                //             margin: const EdgeInsets.only(right: 10),
                //             decoration: BoxDecoration(
                //               color: selectedDate.value == index
                //                   ? AppColors.primaryColor
                //                   : AppColors.primaryColor.withValues(
                //                       alpha: 0.5,
                //                     ),
                //               borderRadius: BorderRadius.circular(12),
                //             ),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   DateFormat('E').format(date),
                //                   style: Get.textTheme.bodyMedium!.copyWith(
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.bold,
                //                     color: selectedDate.value == index
                //                         ? Colors.white
                //                         : Colors.black,
                //                   ),
                //                 ),
                //                 Text(
                //                   DateFormat('dd').format(date),
                //                   style: Get.textTheme.bodyMedium!.copyWith(
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.bold,
                //                     color: selectedDate.value == index
                //                         ? Colors.white
                //                         : Colors.black,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // SizedBox(height: Get.height * 0.03),
                buildAllHistoryCards(),
                Obx(() {
                  if (isLoadingMore.value &&
                      userController.rideHistory.isNotEmpty) {
                    return const Loader1();
                  }
                  return const SizedBox.shrink();
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
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
      // centerTitle: true,
      toolbarHeight: 80,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (context) => buildFilterBottomSheet(context),
            );
          },
        ),
      ],
    );
  }

  Widget buildFilterBottomSheet(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Filter Trips',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C2C2C),
              ),
            ),
            const SizedBox(height: 32),

            // Status Filter
            Obx(
              () => _buildFilterSection(
                title: 'Status',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: statusOptions.map((status) {
                    bool isSelected = selectedStatus.value == status;
                    return GestureDetector(
                      onTap: () => selectedStatus.value = status,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          status,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : Color(0xFF2C2C2C),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Obx(
              () => _buildFilterSection(
                title: 'Time Range',
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: timeRangeOptions.map((range) {
                    bool isSelected = selectedTimeRange.value == range;
                    return GestureDetector(
                      onTap: () => selectedTimeRange.value = range,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.grey[300]!,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          range,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : Color(0xFF2C2C2C),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      selectedStatus.value = 'All';
                      selectedTimeRange.value = 'All Time';
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Clear All',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2C2C2C),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      await userController.getRideHistory(
                        status: selectedStatus.toLowerCase(),
                        timeRange: selectedTimeRange.toLowerCase(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 24),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C2C2C),
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget buildAllHistoryCards() {
    return Obx(() {
      if (userController.isloading.value) {
        return SizedBox(
          height: Get.height * 0.45,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
        );
      }
      if (userController.rideHistory.isEmpty) {
        return SizedBox(
          height: Get.height * 0.45,
          child: const Center(child: Text("No Trips Found")),
        );
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: userController.rideHistory.length,
        itemBuilder: (context, index) {
          final trip = userController.rideHistory[index];
          return _buildTripCard(
            status: trip.status?.value ?? "",
            statusColor: getStatusColor(trip.status?.value)!,
            rideModel: trip,
          );
        },
      );
    });
  }

  Color? getStatusColor(String? status) {
    if (status == null) return null;
    if (status == "completed") return const Color(0xFF4CAF50);
    if (status == "cancelled") return const Color(0xFF9E9E9E);
    if (status == "pending") return const Color(0xFFFF7F50);
    if (status == "accepted") return const Color(0xFFFF7F50);
    return null;
  }

  Widget _buildTripCard({
    required String status,
    required Color statusColor,
    required RideModel rideModel,
  }) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.altTripDetailsScreen,
          arguments: {"rideModel": rideModel},
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: statusColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            ListTile(
              minTileHeight: 45,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text(
                rideModel.pickupLocation?.address ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                DateFormat(
                  'h:mm a',
                ).format(rideModel.requestedAt ?? DateTime.now()),
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
                rideModel.dropOffLocation?.address ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                DateFormat(
                  'h:mm a',
                ).format(rideModel.requestedAt ?? DateTime.now()),
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
                backgroundImage: NetworkImage(
                  rideModel.riderModel?.avatar ?? "",
                ),
              ),
              title: Text(
                "${rideModel.riderModel?.firstName} ${rideModel.riderModel?.lastName}",
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
                    rideModel.rating?.toString() ?? "",
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
                    "\$${rideModel.fare?.toString() ?? ""}",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    rideModel.status?.value ?? "",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
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

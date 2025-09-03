import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/ride_model.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AltTripDetailsScreen extends StatefulWidget {
  final RideModel rideModel;
  const AltTripDetailsScreen({super.key, required this.rideModel});

  @override
  State<AltTripDetailsScreen> createState() => _AltTripDetailsScreenState();
}

class _AltTripDetailsScreenState extends State<AltTripDetailsScreen> {
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    _loadRoute();
  }

  final userController = Get.find<UserController>();

  Future<void> _loadRoute() async {
    final points = await getRoutePoints();
    setState(() {
      polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: points,
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  void addRoute(List<LatLng> points) {
    polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        points: points,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            SizedBox(height: 10),
            ListTile(
              minTileHeight: 45,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(Icons.location_on, color: Colors.green),
              title: Text(
                widget.rideModel.pickupLocation?.address ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              trailing: Text(
                DateFormat(
                  "h:mm a",
                ).format(widget.rideModel.requestedAt ?? DateTime.now()),
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            ListTile(
              minTileHeight: 45,
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(Icons.location_on, color: Colors.orange),
              title: Text(
                widget.rideModel.dropOffLocation?.address ?? "",
                style: Get.textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              // trailing: Text(
              //   "1:21pm",
              //   style: Get.textTheme.bodyMedium!.copyWith(
              //     fontSize: 11,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.rideModel.pickupLocation?.lat ?? 0,
                    widget.rideModel.pickupLocation?.lng ?? 0,
                  ),
                  zoom: 12,
                ),
                zoomControlsEnabled: false,
                mapType: MapType.terrain,
                polylines: polylines,
              ),
            ),
            SizedBox(height: 10),
            _buildTripInfoDetails(),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.rideModel.riderModel?.avatar ?? "",
                ),
              ),
              title: Text(
                widget.rideModel.riderModel?.firstName ?? "",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.orange),
                  Text(
                    widget.rideModel.rating.toString(),
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: Get.height * 0.03),
            // Container(
            //   width: Get.width,
            //   color: Colors.grey.shade300.withValues(alpha: 0.5),
            //   padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
            //   child: Text(
            //     "Need help?",
            //     style: GoogleFonts.manrope(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w600,
            //       color: Colors.black,
            //     ),
            //   ),
            // ),
            // SizedBox(height: Get.height * 0.01),
            // _buildHelpTile(title: "Passenger lost an item"),
            // _buildHelpTile(title: "Passenger was rude"),
            // _buildHelpTile(title: "Security Issues"),
            // _buildHelpTile(title: "Passenger didn’t arrive"),
            // SizedBox(height: Get.height * 0.05),
          ],
        ),
      ),
    );
  }

  Column _buildHelpTile({required String title}) {
    return Column(
      children: [
        ListTile(
          minTileHeight: 30,
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          title: Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
        ),
        Divider(),
      ],
    );
  }

  Column _buildTripInfoDetails() {
    final userModel = userController.userModel;
    return Column(
      children: [
        // _buildTile(
        //   title: "Distance",
        //   value: "${widget.rideModel.eta?.distance}km",
        // ),
        // _buildTile(title: "Ride duration", value: "22 min"),
        _buildTile(
          title: "Vehicle type",
          value: userModel.value?.driverProfile?.carModel ?? "",
        ),
        _buildTile(
          title: "Vehicle Color",
          value: userModel.value?.driverProfile?.carColor ?? "",
        ),
      ],
    );
  }

  Widget _buildTile({required String title, required String value}) {
    return ListTile(
      minTileHeight: 30,
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      title: Text(
        title,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      trailing: Text(
        value,
        style: Get.textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      width: Get.width,
      color: Colors.grey.shade300.withValues(alpha: 0.5),
      alignment: Alignment.center,
      child: Text(
        "Ride Completed",
        style: GoogleFonts.manrope(
          color: Colors.green,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "Ride Details",
        style: Get.textTheme.bodyMedium!.copyWith(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      leadingWidth: 30,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  Future<List<LatLng>> getRoutePoints() async {
    final start = LatLng(
      widget.rideModel.pickupLocation?.lat ?? 0,
      widget.rideModel.pickupLocation?.lng ?? 0,
    );
    final end = LatLng(
      widget.rideModel.dropOffLocation?.lat ?? 0,
      widget.rideModel.dropOffLocation?.lng ?? 0,
    );
    final url =
        'https://us1.locationiq.com/v1/directions/driving/'
        '${start.longitude},${start.latitude};${end.longitude},${end.latitude}'
        '?key=pk.d074964679caaa4f8b75ed81cd6b038a&overview=full&geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coords = data['routes'][0]['geometry']['coordinates'] as List;

      // Convert [lon, lat] → LatLng(lat, lon)
      return coords.map((c) => LatLng(c[1], c[0])).toList();
    } else {
      throw Exception('Failed to fetch route');
    }
  }
}

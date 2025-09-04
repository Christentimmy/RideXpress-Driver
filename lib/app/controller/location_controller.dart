import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/socket_controller.dart';
import 'package:ridexpressdriver/app/controller/user_controller.dart';
import 'package:ridexpressdriver/app/data/models/user_model.dart';

class LocationController extends GetxController {
  Position? lastPosition;
  final int distanceThreshold = 150;
  final _userController = Get.find<UserController>();

  final isloading = false.obs;
  final socketController = Get.find<SocketController>();

  Future<void> initializeLocation() async {
    isloading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }

    try {
      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        initialPosition.latitude,
        initialPosition.longitude,
      );

      await _userController.updateLocation(
        location: LocationModel(
          lat: initialPosition.latitude,
          lng: initialPosition.longitude,
          address: placemarks.first.subAdministrativeArea ?? "",
        ),
      );
    } catch (e) {
      debugPrint("Error fetching initial location: $e");
    } finally {
      isloading.value = false;
    }
  }

  void startLocationUpdates() async {
    await initializeLocation();

    if (socketController.socket == null ||
        !socketController.socket!.connected) {
      return;
    }

    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: distanceThreshold,
      ),
    ).listen((Position position) {
      updateDriverLocation(position);
    });
  }

  void updateDriverLocation(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (socketController.socket != null && socketController.socket!.connected) {
      socketController.updateLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        address: placemarks.first.subAdministrativeArea ?? "",
      );
    } else {
      print("Socket disconnected, cannot send location updates.");
    }
  }

  Future<LocationModel?> useMyCurrentLocation() async {
    isloading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return null;
    }

    try {
      Position initialPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        initialPosition.latitude,
        initialPosition.longitude,
      );

      return LocationModel(
        address: placemarks.first.subAdministrativeArea ?? "",
        lat: initialPosition.latitude,
        lng: initialPosition.longitude,
      );
    } catch (e) {
      print("Error fetching initial location: $e");
    } finally {
      isloading.value = false;
    }
    return null;
  }
}

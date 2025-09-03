import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ridexpressdriver/app/controller/socket_controller.dart';
import 'package:ridexpressdriver/app/modules/home/views/home_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/settings_screen.dart';
import 'package:ridexpressdriver/app/modules/trip/views/alt_my_trips_screen.dart';
import 'package:ridexpressdriver/app/utils/colors.dart';

class BottomNaviagtionWidget extends StatefulWidget {
  const BottomNaviagtionWidget({super.key});

  @override
  State<BottomNaviagtionWidget> createState() => _BottomNaviagtionWidgetState();
}

class _BottomNaviagtionWidgetState extends State<BottomNaviagtionWidget> {
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    AltMyTripsScreen(),
    SettingsScreen(),
  ];

  final socketController = Get.find<SocketController>();
  @override
  void initState() {
    super.initState();
    if (socketController.socket == null || !socketController.socket!.connected) {
      socketController.initializeSocket();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          onTap: (index) {
            currentIndex.value = index;
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

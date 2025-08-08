import 'package:get/get.dart';
import 'package:ridexpressdriver/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:ridexpressdriver/app/modules/splash/views/splash_screen.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
  ];
}

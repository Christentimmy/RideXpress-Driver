import 'package:get/get.dart';
import 'package:ridexpressdriver/app/modules/auth/views/otp_verification_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/phone_authentication_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/signup_screen.dart';
import 'package:ridexpressdriver/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/select_vehicle_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/upload_profile.dart';
import 'package:ridexpressdriver/app/modules/splash/views/splash_screen.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(
      name: AppRoutes.phoneNumberAuthentication,
      page: () => PhoneAuthenticationScreen(),
    ),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpVerificationScreen()),
    GetPage(name: AppRoutes.uploadProfile, page: () => UploadProfile()),
    GetPage(name: AppRoutes.selectVehicle, page: () => SelectVehicleScreen()),
  ];
}

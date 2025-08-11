import 'package:get/get.dart';
import 'package:ridexpressdriver/app/modules/auth/views/change_password_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/otp_verification_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/login_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/phone_authentication_screen.dart';
import 'package:ridexpressdriver/app/modules/auth/views/signup_screen.dart';
import 'package:ridexpressdriver/app/modules/chat/view/chat_screen.dart';
import 'package:ridexpressdriver/app/modules/home/views/home_screen.dart';
import 'package:ridexpressdriver/app/modules/home/views/rate_driver_screen.dart';
import 'package:ridexpressdriver/app/modules/onboarding/views/onboarding_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/document_disclaimer_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/edit_profile_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/scan_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/select_vehicle_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/submit_documents_screen.dart';
import 'package:ridexpressdriver/app/modules/profile/views/upload_profile.dart';
import 'package:ridexpressdriver/app/modules/profile/views/vehicle_details_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/acceptance_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/cancellation_rate_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/rating_stat_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/trips_stats_screen.dart';
import 'package:ridexpressdriver/app/modules/settings/views/settings_screen.dart';
import 'package:ridexpressdriver/app/modules/splash/views/splash_screen.dart';
import 'package:ridexpressdriver/app/modules/trip/views/alt_my_trips_screen.dart';
import 'package:ridexpressdriver/app/modules/trip/views/alt_trip_details_screen.dart';
import 'package:ridexpressdriver/app/routes/app_routes.dart';
import 'package:ridexpressdriver/app/widgets/bottom_naviagtion_widget.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.signup, page: () => SignupScreen()),
    GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
    GetPage(name: AppRoutes.otpScreen, page: () => OtpVerificationScreen()),
    GetPage(name: AppRoutes.uploadProfile, page: () => UploadProfile()),
    GetPage(name: AppRoutes.selectVehicle, page: () => SelectVehicleScreen()),
    GetPage(
      name: AppRoutes.phoneAuthentication,
      page: () => PhoneAuthenticationScreen(),
    ),
    GetPage(name: AppRoutes.vehicleDetails, page: () => VehicleDetailsScreen()),
    GetPage(
      name: AppRoutes.submitDocuments,
      page: () => SubmitDocumentsScreen(),
    ),
    GetPage(
      name: AppRoutes.documentDisclaimer,
      page: () => DocumentDisclaimerScreen(),
    ),
    GetPage(name: AppRoutes.scanScreen, page: () => ScanScreen()),
    GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
    GetPage(name: AppRoutes.chatScreen, page: () => ChatScreen()),
    GetPage(name: AppRoutes.rateDriverScreen, page: () => RateDriverScreen()),
    GetPage(
      name: AppRoutes.bottomNavigationWidget,
      page: () => BottomNaviagtionWidget(),
    ),
    GetPage(name: AppRoutes.altMyTripsScreen, page: () => AltMyTripsScreen()),
    GetPage(
      name: AppRoutes.altTripDetailsScreen,
      page: () => AltTripDetailsScreen(),
    ),
    GetPage(name: AppRoutes.settingsScreen, page: () => SettingsScreen()),
    GetPage(name: AppRoutes.tripsStatsScreen, page: () => TripsStatsScreen()),
    GetPage(name: AppRoutes.acceptanceScreen, page: () => AcceptanceScreen()),
    GetPage(
      name: AppRoutes.cancellationRateScreen,
      page: () => CancellationRateScreen(),
    ),
    GetPage(
      name: AppRoutes.ratingStatScreen,
      page: () => RatingStatScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfileScreen,
      page: () => EditProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.changePasswordScreen,
      page: () => ChangePasswordScreen(),
    ),


  ];
}

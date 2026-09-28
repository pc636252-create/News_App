import 'package:get/get.dart';
import 'package:news_app/Controller/Forgot_Controller.dart';
import 'package:news_app/Controller/SignIn_Controller.dart';
import 'package:news_app/Controller/Verification_Controller.dart';
import 'package:news_app/Controller/city_Controller.dart';
import 'package:news_app/Routes/App_Routes.dart';
import 'package:news_app/Screen_controllers/Home_Controller.dart';
import 'package:news_app/Screen_controllers/PopularTags_Controller.dart';
import 'package:news_app/Screen_controllers/Profile_Controller.dart';
import 'package:news_app/Screens/BottomNevigation/BottomNevigation.dart';
import 'package:news_app/Setting/Seting_.dart';
import 'package:news_app/Screen_controllers/SettingController.dart';
import '../AuthScreens/CityScreen.dart';
import '../AuthScreens/ForgetScreen.dart';
import '../AuthScreens/SignIn.dart';
import '../AuthScreens/SignUp.dart';
import '../AuthScreens/SplashScreen.dart';
import '../AuthScreens/VerificationCode.dart';
import '../Controller/SignUp_Controller.dart';
import '../Controller/Splash_Controller.dart';
import '../Screen_controllers/BottomNevigation.dart';
import '../Screen_controllers/Post_Controller.dart';
import '../Screens/HomeScreen/HomeScreen.dart';
import '../Screens/PopularTagsScreen/PopularTagsScreen.dart';
import '../Screens/PostScreen/PostScreen.dart';
import '../Screens/ProfileScreen/ProfileScreen.dart';

class AppPage {
  static final screens = [
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignIn(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignInController>(() => SignInController());
      }),
    ),
    GetPage(
      name: AppRoutes.signUp,
      page: () => const SignUp(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SignUpController>(() => SignUpController());
      }),
    ),
    GetPage(
      name: AppRoutes.verifyCode,
      page: () => const VerificationCode(),
      binding: BindingsBuilder(() {
        Get.lazyPut<VerificationController>(() => VerificationController());
      }),
    ),
    GetPage(
      name: AppRoutes.forgotScreen,
      page: () => const ForgotScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ForgotController>(() => ForgotController());
      }),
    ),
    GetPage(
      name: AppRoutes.city,
      page: () => const CitySelectionScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<CityController>(() => CityController());
      }),
    ),
    GetPage(
      name: AppRoutes.navigation,
      page: () =>  NavigationScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NavigationController>(() => NavigationController());
        Get.lazyPut<HomeController>(() => HomeController());
        Get.lazyPut<PopularController>(() => PopularController()); 
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () =>  HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<HomeController>(() => HomeController());
      }),
    ),
    GetPage(
      name: AppRoutes.post,
      page: () => const PostScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PostController>(() => PostController());
      }),
    ),
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => const ProfileScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
    ),
    GetPage(
      name: AppRoutes.popularTags,
      page: () => const PopularTags(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PopularController>(() => PopularController());
      }),
    ),
  ];
}

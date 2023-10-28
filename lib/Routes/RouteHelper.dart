import 'package:get/get.dart';

import '../AuthScreen/IntroScreen.dart';
import '../AuthScreen/LoginScreen.dart';
import '../AuthScreen/OtpScreen.dart';
import '../AuthScreen/SignInScreen.dart';
import '../AuthScreen/SignUpScreen.dart';
import '../AuthScreen/SplashScreen.dart';
import '../UserScerrn/DelightSelectScreen.dart';
import '../UserScerrn/DelightsScreen.dart';
import '../UserScerrn/DetailsScreen.dart';
import '../UserScerrn/ExploreOnScreen.dart';
import '../UserScerrn/ExploreScreen.dart';
import '../UserScerrn/HomeScreen.dart';
import '../UserScerrn/ProfileEdit.dart';
import '../UserScerrn/UserProfile.dart';
import '../UserScerrn/ReviewAddScreen.dart';
import '../UserScerrn/VideoReviewDetailsScreen.dart';

class RouteHelper {
  //copy from code editor
  // static const String MyHomePagepage = "/MyHomePage";
  static const String splashScreenpage = "/splash_screen";
  static const String introScreen = "/IntroScreen";
  static const String signUpScreen = "/SignUpScreen";
  static const String signInScreen = "/SignInScreen";
  static const String loginpage = "/login_screen";
  static const String otpScreenpage = "/Otp_screen";
  static const String delightsScreenpage = "/Delights_Screen";
  static const String delightSelectScreen = "/DelightSelectScreen";
  static const String exploreScreenpage = "/Explore_Screen";
  static const String exploreOnScreenpage = "/Explore_On_Screen";
  static const String profileScreenpage = "/User_Profile_screen";
  static const String profileEditpage = "/Profile_Edit_screen";
  static const String homeScreenpage = "/home_screen";
  static const String detailsScreen = "/Details_Screen";
  static const String reviewaddScreen = "/ReviewAddScreen";
  static const String videoReviewDetailsScreen = "/VideoReviewDetailsScreen";

  //copy from code editor
  // static String getMyHomePagepage ()=> '$MyHomePagepage';

  static String getSplashScreenPage() => '$splashScreenpage';
  static String getIntroScreen() => '$introScreen';
  static String getSignUpScreen() => '$signUpScreen';
  static String getSignInScreen() => '$signInScreen';
  static String getLoginpage() => '$loginpage';
  static String getotpScreenpage() => '$otpScreenpage';
  static String getdelightsScreenpage() => '$delightsScreenpage';
  static String getDelightSelectScreen() => '$delightSelectScreen';
  static String getexploreScreenpage() => '$exploreScreenpage';
  static String getexploreOnScreenpage() => '$exploreOnScreenpage';
  static String getprofileScreenpage() => '$profileScreenpage';
  static String getprofileEditpage() => '$profileEditpage';
  static String getHomeScreenpage() => '$homeScreenpage';
  static String getdetailsScreen() => '$detailsScreen';
  static String getaddreviewScreen() => '$reviewaddScreen';
  static String getVideoReviewDetailsScreen() => '$videoReviewDetailsScreen';
  static List<GetPage> routes = [
    // GetPage(name: MyHomePagepage, page: (){
    //   return AnimatedXYZ();
    // },
    //     transition: Transition.zoom
    // ),
    //
    GetPage(
        name: splashScreenpage,
        page: () {
          return SplashScreen();
        },
        transition: Transition.zoom),

    GetPage(
        name: loginpage,
        page: () {
          return LoginScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: otpScreenpage,
        page: () {
          return OtpScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: delightsScreenpage,
        page: () {
          return DelightsScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: delightSelectScreen,
        page: () {
          return DelightSelectScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: exploreScreenpage,
        page: () {
          return ExploreScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: exploreOnScreenpage,
        page: () {
          return ExploreOnScreen();
        },
        transition: Transition.size),

    GetPage(
        name: profileScreenpage,
        page: () {
          return UserProfile();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: profileEditpage,
        page: () {
          return ProfileEdit();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: homeScreenpage,
        page: () {
          return HomeScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: detailsScreen,
        page: () {
          return const DetailsScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: introScreen,
        page: () {
          return IntroScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: signUpScreen,
        page: () {
          return SignUpScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: signInScreen,
        page: () {
          return SignInScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: reviewaddScreen,
        page: () {
          return ReviewAddScreen();
        },
        transition: Transition.fadeIn),

    GetPage(
        name: videoReviewDetailsScreen,
        page: () {
          return VideoReviewDetailsScreen(filePath: '', videorating: '', videoDate: '', videoName: '',);
        },
        transition: Transition.fadeIn),
  ];
}

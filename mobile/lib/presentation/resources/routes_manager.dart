import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/forgot_password/otp_code/view/reset_password_otp_view.dart';
import 'package:sed/presentation/forgot_password/reset_password/view/reset_password_view.dart';
import 'package:sed/presentation/login/view/login_view.dart';
import 'package:sed/presentation/main_screen/items_screen/showProfile/view/show_profile_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/categories/categories_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/view/add_advertisement_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/message/view/message_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/view/chat_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/notification_screen/view/notifications_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/settings_sub_screens/about_us_screen/aboutus_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/settings_sub_screens/help_screen/help_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view/show_items_screen_view.dart';
import 'package:sed/presentation/main_screen/utils/camera_screen/view/camera_screen_view.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/onboarding/view/onboarding_view.dart';
import 'package:sed/presentation/register/view/register_view.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../domain/model/models.dart';
import '../forgot_password/view/forgotpassword_view.dart';
import '../main_screen/items_screen/view/products_screen_view.dart';
import '../main_screen/main_screen_view/main_screen_view.dart';
import '../main_screen/sub_screens/search_screen/view/search_view.dart';
import '../main_screen/sub_screens/settings_screen/settings_sub_screens/change_password_screen/view/change_password_screen_view.dart';
import '../main_screen/sub_screens/settings_screen/settings_sub_screens/my_account_screen/view/my_account_screen_view.dart';
import '../main_screen/sub_screens/settings_screen/settings_sub_screens/my_ads_screen/view/my_ads_view.dart';
import '../register/email_verification/view/email_verification_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String resetPasswordRoute = "/resetPassword";
  static const String emailVerificationRoute = "/emailVerification";
  static const String registerRoute = "/register";
  static const String resetPasswordOTPRoute = "/resetPasswordOTP";
  static const String mainScreenRoute = "/main";
  static const String itemScreenRoute = "/item";
  static const String showItemsScreenRoute = "/showItems";
  static const String categoriesScreenRoute = "/categories";
  static const String showProfileScreenRoute = "/showProfile";
  static const String addProductScreenRoute = "/addProduct";
  static const String myAdsScreenRoute = "/myAds";
  static const String aboutUsScreenRoute = "/aboutUs";
  static const String helpScreenRoute = "/help";
  static const String searchScreenRoute = "/search";
  static const String notificationsScreenRoute = "/notifications";
  static const String myAccountScreenRoute = "/myAccount";
  static const String changePasswordScreenRoute = "/changePassword";
  static const String messagingScreenRoute = "/messaging";
  static const String cameraScreenRoute = "/camera";
  static const String chatScreenRoute = "/chat";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    if (settings.name != Routes.messagingScreenRoute) {
      Utils.isInMessageScreen = false;
    } else {
      Utils.isInMessageScreen = true;
    }

    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView());

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordView());

      case Routes.resetPasswordOTPRoute:
        initRegisterModule();
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordOTPView());

      case Routes.resetPasswordRoute:
        return MaterialPageRoute(
            builder: (context) => const ResetPasswordView());

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterView());

      case Routes.emailVerificationRoute:
        initRegisterModule();
        return MaterialPageRoute(
            builder: (context) => const EmailVerificationScreenView());

      case Routes.mainScreenRoute:
        return MaterialPageRoute(builder: (context) => const MainScreenView());

      case Routes.itemScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ProductView(settings.arguments));

      case Routes.showItemsScreenRoute:
        List<dynamic> args = settings.arguments as List<dynamic>;

        if (args.length <= 2) {
          return MaterialPageRoute(
              builder: (context) => ShowItemsView(
                    args[0],
                    categoryName: args[1],
                  ));
        }

        return MaterialPageRoute(
            builder: (context) => ShowItemsView(
                  args[0],
                  categoryName: args[1],
                  image: args[2],
                ));

      case Routes.categoriesScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreenView());

      // show profile screen for other users
      case Routes.showProfileScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ShowProfileView(settings.arguments));

      case Routes.addProductScreenRoute:
        List<dynamic> args = settings.arguments as List<dynamic>;

        return MaterialPageRoute(
            builder: (context) =>
                AddAdvertisementView(args[0] as int, args[1] as Items?));

      case Routes.myAdsScreenRoute:
        return MaterialPageRoute(builder: (context) => const MyAdsScreenView());

      case Routes.aboutUsScreenRoute:
        return MaterialPageRoute(builder: (context) => const AboutUsScreen());

      case Routes.helpScreenRoute:
        return MaterialPageRoute(builder: (context) => const HelpScreen());

      case Routes.searchScreenRoute:
        return MaterialPageRoute(builder: (context) => const SearchView());

      case Routes.notificationsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const NotificationScreenView());

      case Routes.myAccountScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const MyAccountScreenView());

      case Routes.changePasswordScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ChangePasswordScreenView());

      case Routes.messagingScreenRoute:
        List<dynamic> args = settings.arguments as List<dynamic>;

        return MaterialPageRoute(
            builder: (context) =>
                MessagingScreenView(args[0], args[1], args[2], args[3]));

      case Routes.cameraScreenRoute:
        initLoginModule();
        return MaterialPageRoute(
            builder: (context) => const CameraScreenView());

      case Routes.chatScreenRoute:
        return MaterialPageRoute(builder: (context) => const ChatScreenView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteTitle.tr()),
              ),
              body: Center(child: Text(AppStrings.noRouteFound.tr())),
            ));
  }
}

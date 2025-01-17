const String imagePath = 'assets/images';

const String jsonPath = 'assets/json';

class ImageAssets {
  //splash screen
  static const String lightModeSplashLogo = '$imagePath/light_mode_logo.png';
  static const String darkModeSplashLogo = '$imagePath/dark_mode_logo.png';
  static const String onBoardingLogo = '$imagePath/onboarding_logo.png';
  static const String loginDarkModeLoginLogoDarkMode =
      '$imagePath/login_dark_mode_logo_dark_mode.png';
  static const String loginDarkModeLoginLogoLightMode =
      '$imagePath/login_dark_mode_logo_light_mode.png';
  static const String loginBackgroundDarkMode =
      '$imagePath/login_background_dark_mode.png';
  static const String loginBackgroundLightMode =
      '$imagePath/login_background_light_mode.png';
  static const String noImage = "$imagePath/no_image.png";
  static const String emailVerification = "$imagePath/email_verification.png";
  static const String egyptFlag = "$imagePath/egypt.png";

  static const String leftArrowIcon = "$imagePath/left_arrow_icon.svg";
  static const String rightArrowIcon = "$imagePath/right_arrow_icon.svg";
  static const String hollowCircleIcon = "$imagePath/hollow_circle_icon.svg";
  static const String solidCircleIcon = "$imagePath/solid_circle_icon.svg";
}

class JsonAssets {
  //onboarding screen
  static const List<String> onBoardingLogos = [
    "$jsonPath/on_boarding_sell.json",
    "$jsonPath/on_boarding_exchange.json",
    "$jsonPath/on_boarding_donate.json",
  ];
  //state renderer
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
  static const String success = "$jsonPath/success.json";
  static const String verificationOTP = "$jsonPath/verification_code_otp.json";
  static const String resetPassword = "$jsonPath/reset_password.json";
}

import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const v1 = 'v1';
  static const upload = '$v1/upload';

  static const String geoCoderApi =
      'https://maps.googleapis.com/maps/api/geocode/json';

  static const String authentication = "authentication";
  static const String user = '$v1/users';
  static const String signInWithGoogle = "$v1/authenticate-google";
  static const String signInWithFacebook = '$v1/authenticate-fb';
  static const String signInWithApple = '$v1/authenticate-apple';
  static const String signInWithPhone = '$v1/authenticate-phone';
  static const String forgotPassword = 'forget-password';
  static const String forgotPasswordRequestOTP =
      '$v1/$forgotPassword/request-otp';
  static const String forgotPasswordVerifyOTP =
      '$v1/$forgotPassword/verify-password-otp';

  static const String checkForgotUser = '$v1/check-forgot-user';
  static const String requestResetToken = '$v1/reset-token';
  static const String resetPassword = '$v1/$forgotPassword/reset-password';
}

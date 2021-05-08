import 'environment.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const v1 = 'v1';
  static const upload = '$v1/upload-photo';

  static const String geoCoderApi =
      'https://maps.googleapis.com/maps/api/geocode/json';

  static const String phoneVerification = "$v1/phone-verification";
  static const String authenticatePhone = "$v1/authenticate-phone";
  static const String user = '$v1/user';
  static const String userDetails = '$v1/user-details';
  static const String signInWithGoogle = "$v1/login/google-login";
  static const String signInWithFacebook = '$v1/login/facebook-login';
  static const String signInWithApple = '$v1/login/apple-login';
  static String authenticateJwt = '$v1/authenticate-jwt';

  static String speciality = '$v1/speciality';
  static String addFamilyMember = '$v1/family';
  static String addAddress = '$v1/address';
  static String contactUs = '$v1/contact-us';
  static String feedback = '$v1/feedback';
  static String habit = '$v1/habit';
  static String symptom = '$v1/symptom';
  static String prescription = '$v1/prescription';
  static String orderRequest = '$v1/order-request';
  static String bookOrder = '$v1/book-order';
  static String order = '$v1/order';
}

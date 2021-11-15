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

  static const String emailVerification = "$v1/verification";
  static const String authenticateEmail = "$v1/authenticate";
  static const String user = '$v1/user';
  static const String signInWithGoogle = "$v1/login/google-login";
  static const String signInWithFacebook = '$v1/login/facebook-login';
  static const String signInWithApple = '$v1/login/apple-login';
  static String authenticateJwt = '$v1/authenticate-jwt';
}

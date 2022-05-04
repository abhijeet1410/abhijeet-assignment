import 'dart:developer';

import 'package:flutter_mobile_template/api_services/base_api.dart';
import 'package:flutter_mobile_template/app_configs/api_routes.dart';
import 'package:flutter_mobile_template/data_models/user.dart';
import 'package:flutter_mobile_template/global_controllers/user_controller.dart';
import 'package:flutter_mobile_template/pages/authenticaton/login_phone/login_phone_page.dart';
import 'package:flutter_mobile_template/pages/dashboard/dashboard_page.dart';
import 'package:flutter_mobile_template/utils/shared_preference_helper.dart';
import 'package:get/get.dart';

import 'snackbar_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  static Future<dynamic> sendEmailOtp(String email) async {
    final result = await ApiCall.post(ApiRoutes.emailVerification,
        body: {"email": email}, isAuthNeeded: false);
    log('OTP result $result');
    SnackBarHelper.show("OTP sent to $email");
    return result.data;
  }

  // static Future<UserResponse> verifyLoginOtp(String phone, String otp) async {
  // final fcmId = await FirebaseMessaging.instance.getToken();
  //   final Position latLng = await CheckPermissions.getCurrentLocation();
  //
  //   final deviceInfo = await getDeviceDetails();
  //   final fcmId = await FirebaseMessaging.instance.getToken();
  //
  //   final result = await ApiCall.post(ApiRoutes.authenticatePhone,
  //       body: {
  //         "phone": phone,
  //         "otp": otp,
  //         "action": "authentication",
  //         "fcmId": fcmId,
  //         "deviceId": deviceInfo['deviceId'],
  //         "deviceType": deviceInfo['deviceType'],
  //         "deviceName": deviceInfo['deviceName'],
  //         "coordinates": [latLng.longitude, latLng.latitude],
  //         "role": 1
  //       },
  //       query: {'\$populate': 'userDetails'},
  //       isAuthNeeded: false);
  //   return UserResponse.fromJson(result.data);
  // }

  // static Future<Map<String, dynamic>> getDeviceDetails() async {
  //   String? deviceName;
  //   String? identifier;
  //   int? deviceType;
  //   final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       deviceType = 1;
  //       final build = await deviceInfoPlugin.androidInfo;
  //       deviceName = build.model;
  //       //deviceVersion = build.version.toString();
  //       identifier = build.androidId; //UUID for Android
  //     } else if (Platform.isIOS) {
  //       deviceType = 2;
  //       final data = await deviceInfoPlugin.iosInfo;
  //       deviceName = data.name;
  //       //deviceVersion = data.systemVersion;
  //       identifier = data.identifierForVendor; //UUID for iOS
  //     }
  //   } on PlatformException {
  //     throw 'Failed to get platform version';
  //   }
  //   return {
  //     "deviceId": Platform.isAndroid ? 1 : 2,
  //     "deviceName": deviceName,
  //     "deviceType": deviceType
  //   };
  // }

  // static Future<UserResponse?> userLoginWithGoogle() async {
  //   GoogleSignIn _googleSignIn =
  //       GoogleSignIn(scopes: ['email'], clientId: Environment.googleClientId);
  //   try {
  //     final Position latLng = await CheckPermissions.getCurrentLocation();
  //
  //     final deviceInfo = await getDeviceDetails();
  //     final fcmId = await FirebaseMessaging.instance.getToken();
  //     GoogleSignInAccount? result = await _googleSignIn.signIn();
  //     if (result == null) {
  //       return null;
  //     }
  //     GoogleSignInAuthentication googleAuth = await result.authentication;
  //     log('TOKEN ${googleAuth.accessToken}');
  //     final resultMap = await ApiCall.post(ApiRoutes.signInWithGoogle,
  //         query: {'\$populate': 'userDetails'},
  //         body: {
  //           "accessToken": googleAuth.accessToken,
  //           "fcmId": fcmId,
  //           "deviceId": deviceInfo['deviceId'],
  //           "deviceType": deviceInfo['deviceType'],
  //           "deviceName": deviceInfo['deviceName'],
  //           "coordinates": [latLng.longitude, latLng.latitude],
  //           "role": 1
  //         },
  //         isAuthNeeded: false);
  //     final userResponse = UserResponse.fromJson(resultMap.data);
  //     SharedPreferenceHelper.storeUser(user: userResponse);
  //     SharedPreferenceHelper.storeAccessToken(userResponse.accessToken);
  //     return userResponse;
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     _googleSignIn.signOut();
  //   }
  // }

  // static Future<UserResponse?> userLoginWithFacebook() async {
  //   final fcmId = await FirebaseMessaging.instance.getToken();
  //   final Position latLng = await CheckPermissions.getCurrentLocation();
  //   final deviceInfo = await getDeviceDetails();
  //
  //   final facebookLogin = FacebookLogin();
  //   final facebookLoginResult = await facebookLogin.logIn(['email']);
  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.error:
  //       throw FacebookLoginStatus.error.toString();
  //     case FacebookLoginStatus.cancelledByUser:
  //       return null;
  //     case FacebookLoginStatus.loggedIn:
  //       log('TOKEN ${facebookLoginResult.accessToken.token}');
  //
  //       final resultMap = await ApiCall.post(ApiRoutes.signInWithFacebook,
  //           query: {'\$populate': 'business'},
  //           body: {
  //             "accessToken": facebookLoginResult.accessToken.token,
  //             "fcmId": fcmId,
  //             "deviceId": deviceInfo['deviceId'],
  //             "deviceType": deviceInfo['deviceType'],
  //             "deviceName": deviceInfo['deviceName'],
  //             "coordinates": [latLng.longitude, latLng.latitude],
  //             "role": 1
  //           },
  //           isAuthNeeded: false);
  //
  //       await facebookLogin.logOut();
  //
  //       final userResponse = UserResponse.fromJson(resultMap.data);
  //       SharedPreferenceHelper.storeUser(user: userResponse);
  //       SharedPreferenceHelper.storeAccessToken(userResponse.accessToken);
  //       return userResponse;
  //     default:
  //       return null;
  //   }
  // }

  // static Future<UserResponse?> userLoginWithApple() async {
  //   final fcmId = await FirebaseMessaging.instance.getToken();
  //   final Position latLng = await CheckPermissions.getCurrentLocation();
  //   final deviceInfo = await getDeviceDetails();
  //   try {
  //     final credential = await SignInWithApple.getAppleIDCredential(
  //       // TODO: set client id and redirect url
  //
  //       webAuthenticationOptions:
  //           WebAuthenticationOptions(clientId: '', redirectUri: Uri.parse('')),
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );
  //     final resultMap = await ApiCall.post(ApiRoutes.signInWithApple,
  //         query: {'\$populate': 'business'},
  //         body: {
  //           "accessToken": credential.identityToken,
  //           "fcmId": fcmId,
  //           "deviceId": deviceInfo['deviceId'],
  //           "deviceType": deviceInfo['deviceType'],
  //           "deviceName": deviceInfo['deviceName'],
  //           "coordinates": [latLng.longitude, latLng.latitude],
  //           "role": 1
  //         },
  //         isAuthNeeded: false);
  //
  //     final userResponse = UserResponse.fromJson(resultMap.data);
  //     SharedPreferenceHelper.storeUser(user: userResponse);
  //     SharedPreferenceHelper.storeAccessToken(userResponse.accessToken);
  //     return userResponse;
  //   } catch (e) {
  //     if (e is SignInWithAppleAuthorizationException) {
  //       switch (e.code) {
  //         case AuthorizationErrorCode.canceled:
  //           return null;
  //         default:
  //           throw 'Unable to login with apple';
  //       }
  //     }
  //     throw e.toString();
  //   }
  // }

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel(
      {String? parentPath, String? phone}) async {
    final UserResponse? user = SharedPreferenceHelper.user;
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    if (user != null) {
      Get.offAllNamed(DashboardPage.routeName);
    } else if (user == null && user?.accessToken != null) {
      // Get.offNamed(OnboardingPage.routeName);
    } else
      Get.offAllNamed(LoginPhonePage.routeName);
  }

  static Future<String?> refreshAccessToken() async {
    if (SharedPreferenceHelper.user == null) return null;
    final String? oldToken = SharedPreferenceHelper.user?.accessToken;
    if (oldToken?.isEmpty ?? true) return null;
    final result = await ApiCall.post(ApiRoutes.authenticateJwt,
        query: {'\$populate': 'userDetails'}, body: {'accessToken': oldToken});
    final String accessToken = result.data['accessToken'];
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user.user);
    return accessToken;
  }

  static Future<String?> logoutUser() async {
    await ApiCall.post('authentication', basePath: ApiRoutes.baseUrl);
  }

  // static Future<UserResponse> signUpUser(Map<String, dynamic> body) async {
  //   final fcmId = await FirebaseMessaging.instance.getToken();
  //   final Position latLng = await CheckPermissions.getCurrentLocation();
  //   final deviceInfo = await getDeviceDetails();
  //
  //   body.addAll({
  //     "accessToken": SharedPreferenceHelper.accessToken,
  //     "fcmId": fcmId,
  //     "deviceId": deviceInfo['deviceId'],
  //     "deviceType": deviceInfo['deviceType'],
  //     "deviceName": deviceInfo['deviceName'],
  //     "coordinates": [latLng.longitude, latLng.latitude],
  //     "role": 1
  //   });
  //   final result = await ApiCall.post(ApiRoutes.user,
  //       body: body, query: {'\$populate': 'userDetails'});
  //   final user = UserResponse.fromJson(result.data);
  //   SharedPreferenceHelper.storeUser(user: user);
  //   SharedPreferenceHelper.storeAccessToken(user.accessToken);
  //
  //   final userController = Get.isRegistered()
  //       ? Get.find<UserController>()
  //       : Get.put<UserController>(UserController(), permanent: true);
  //   userController.updateUser(user.user);
  //   return user;
  // }

  static Future<User?> updateUser(Map<String, dynamic> body) async {
    final u = SharedPreferenceHelper.user;
    if (u!.user == null) return null;
    final result =
        await ApiCall.patch(ApiRoutes.user, id: u.user!.id, body: body);
    final user = User.fromJson(result.data);
    u.user = user;
    SharedPreferenceHelper.storeUser(user: u);

    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(u.user);
    return user;
  }
}

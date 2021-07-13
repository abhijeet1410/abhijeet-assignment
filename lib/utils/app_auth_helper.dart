import 'dart:developer';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:god_flutter/api_services/base_api.dart';
import 'package:god_flutter/app_configs/api_routes.dart';
import 'package:god_flutter/data_models/user.dart';
import 'package:god_flutter/global_controllers/user_controller.dart';
import 'package:god_flutter/pages/authentication/intro/intro_page.dart';
import 'package:god_flutter/pages/authentication/onboarding/onboarding_page.dart';
import 'package:god_flutter/pages/dashboard/dashboard_page.dart';
import 'package:god_flutter/utils/shared_preference_helper.dart';

import 'snackbar_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  ///
  /// Normal user and business user login
  /// The [phone] is for phone number
  /// On error it will throw [RestError]
  ///
  static Future<dynamic> userLoginWithPhone(String phone) async {
    final result = await ApiCall.post(ApiRoutes.phoneVerification,
        body: {"phone": phone, "action": "authentication"},
        query: {'\$populate': 'userDetails'},
        isAuthNeeded: false);
    log('OTP result $result');
    print('OTP result $result');
    SnackBarHelper.show("", "OTP ${result.data['otp']}}");
    return result.data;
  }

  static Future<UserResponse> verifyLoginOtp(String phone, String otp) async {
    // final fcmId = await FirebaseMessaging.instance.getToken();
    // final Position latLng = await CheckPermissions.getCurrentLocation();

    final deviceInfo = await getDeviceDetails();
    final fcmId = await FirebaseMessaging.instance.getToken();

    final result = await ApiCall.post(ApiRoutes.authenticatePhone,
        body: {
          "phone": phone,
          "otp": otp,
          "action": "authentication",
          "fcmId": fcmId,
          "deviceId": deviceInfo['deviceId'],
          "deviceType": deviceInfo['deviceType'],
          "deviceName": deviceInfo['deviceName'],
          // "coordinates": [latLng.longitude, latLng.latitude],
          "role": 1
        },
        query: {'\$populate': 'userDetails'},
        isAuthNeeded: false);
    return UserResponse.fromJson(result.data);
  }

  static Future<Map<String, dynamic>> getDeviceDetails() async {
    String? deviceName;
    String? identifier;
    int? deviceType;
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        deviceType = 1;
        final build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        //deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        deviceType = 2;
        final data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        //deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      throw 'Failed to get platform version';
    }
    return {
      "deviceId": Platform.isAndroid ? 1 : 2,
      "deviceName": deviceName,
      "deviceType": deviceType
    };
  }

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel(
      {String? parentPath, String? phone}) async {
    final UserResponse? user = SharedPreferenceHelper.user;
    final accessToken = SharedPreferenceHelper.accessToken;
    log('USER ${user?.toJson()} TOKEN $accessToken');
    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    if (user != null) {
      if (user.user == null) {
        Get.offNamed(OnboardingPage.routeName,
            arguments: {'phone': phone, 'parent': parentPath});
      } else if ((user.user?.phone?.isEmpty ?? true) ||
          (user.user?.name?.isEmpty ?? true) ||
          (user.user?.userDetails == null) ||
          (user.user?.userDetails!.gender == 0) ||
          (user.user?.userDetails!.dob == null)) {
        Get.offNamed(OnboardingPage.routeName, arguments: {
          'phone': user.user?.phone,
          'name': user.user?.name,
          'gender': user.user?.userDetails?.gender,
          'dob': user.user?.userDetails?.dob,
          'parent': parentPath
        });
      } else {
        userController.updateUser(user.user);
        if (parentPath != null) {
          Get.until((route) => route.settings.name == parentPath);
        } else {
          Get.offAllNamed(DashboardPage.routeName);
        }
      }
    } else if (user == null && accessToken != null) {
      Get.offNamed(OnboardingPage.routeName);
    } else
      Get.offAllNamed(IntroPage.routeName);
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

  static Future<UserResponse> signUpUser(Map<String, dynamic> body) async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    // final Position latLng = await CheckPermissions.getCurrentLocation();
    final deviceInfo = await getDeviceDetails();

    body.addAll({
      "accessToken": SharedPreferenceHelper.accessToken,
      "fcmId": fcmId,
      "deviceId": deviceInfo['deviceId'],
      "deviceType": deviceInfo['deviceType'],
      "deviceName": deviceInfo['deviceName'],
      // "coordinates": [latLng.longitude, latLng.latitude],
      "role": 1
    });
    final result = await ApiCall.post(ApiRoutes.user,
        body: body, query: {'\$populate': 'userDetails'});
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    SharedPreferenceHelper.storeAccessToken(user.accessToken);

    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(user.user);
    return user;
  }

  static Future<User?> updateUser(Map<String, dynamic> body) async {
    final u = SharedPreferenceHelper.user;
    if (u!.user == null) return null;
    final result = await ApiCall.patch(ApiRoutes.user,
        id: u.user!.id, body: body, query: {'\$populate': 'userDetails'});
    final user = User.fromJson(result.data);
    u.user = user;
    SharedPreferenceHelper.storeUser(user: u);

    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(u.user);
    return user;
  }

  static Future<User?> updateUserDetails(Map<String, dynamic> body) async {
    final u = SharedPreferenceHelper.user;
    if (u!.user == null || u.user?.userDetails == null) return null;
    final result = await ApiCall.patch(ApiRoutes.userDetails,
        id: u.user!.userDetails!.id, body: body);
    final userDetails = UserDetails.fromJson(result.data);
    u.user!.userDetails = userDetails;
    SharedPreferenceHelper.storeUser(user: u);

    final userController = Get.isRegistered()
        ? Get.find<UserController>()
        : Get.put<UserController>(UserController(), permanent: true);
    userController.updateUser(u.user);
    return u.user;
  }
}

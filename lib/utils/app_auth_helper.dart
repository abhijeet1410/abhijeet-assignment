import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mobile_template/api_services/base_api.dart';
import 'package:flutter_mobile_template/app_configs/api_routes.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/data_models/social_signin_response.dart';
import 'package:flutter_mobile_template/data_models/user.dart';
import 'package:flutter_mobile_template/global_controllers/user_controller.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/intro/intro_page.dart';
import 'package:flutter_mobile_template/utils/shared_preference_helper.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthHelper {
  ///
  /// Normal user and business user login
  /// The [field] is for email or password
  /// The [password] is for password
  /// After success if normal user it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// if business user will check for business details and redirects to business on-boarding pages
  /// On error it will throw [RestError]
  ///
  static Future<UserResponse> userLoginWithEmailOrPhone(
      String field, String password) async {
    String path = ApiRoutes.authentication;

    final fcmId = await FirebaseMessaging.instance.getToken();
    final resultMap = await ApiCall.post(path,
        body: {
          "strategy": field.isEmail ? "email" : "phone",
          if (field.isEmail) "email": field else "phone": field,
          "password": password,
          "fcmId": fcmId
        },
        isAuthNeeded: false);

    SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
    final userResponse = UserResponse.fromJson(resultMap.data);
    SharedPreferenceHelper.storeUser(user: userResponse);
    final userController = Get.find<UserController>();
    userController.updateUser(userResponse.user);
    AuthHelper.checkUserLevel();
    return userResponse;
  }

  ///
  /// Normal user Google login
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<SocialSignInResponse?> userLoginWithGoogle() async {
    GoogleSignIn _googleSignIn =
        GoogleSignIn(scopes: ['email'], clientId: Environment.googleClientId);
    try {
      final fcmId = await FirebaseMessaging.instance.getToken();
      GoogleSignInAccount result = (await _googleSignIn.signIn())!;
      if (result == null) {
        return null;
      }
      GoogleSignInAuthentication googleAuth = await result.authentication;
      final resultMap = await ApiCall.post(ApiRoutes.signInWithGoogle,
          query: {'\$populate': 'business'},
          body: {"accessToken": googleAuth.accessToken, "fcmId": fcmId},
          isAuthNeeded: false);
      log('TOKEN ${googleAuth.accessToken} ${resultMap.data}');

      if (resultMap.data['accessToken'] != null) {
        SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
        final userResponse = UserResponse.fromJson(resultMap.data);
        SharedPreferenceHelper.storeUser(user: userResponse);

        final userController = Get.find<UserController>();
        userController.updateUser(userResponse.user);

        AuthHelper.checkUserLevel();
        return null;
      } else {
        return SocialSignInResponse.fromJson(resultMap.data);
      }
    } catch (e) {
      rethrow;
    } finally {
      _googleSignIn.signOut();
    }
  }

  ///
  /// Normal user Facebook login
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<SocialSignInResponse?> userLoginWithFacebook() async {
    final fcmId = await FirebaseMessaging.instance.getToken();

    final facebookLogin = FacebookLogin();
    final facebookLoginResult = await facebookLogin.logIn(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        throw FacebookLoginStatus.error.toString();
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.loggedIn:
        log('TOKEN ${facebookLoginResult.accessToken.token}');

        final resultMap = await ApiCall.post(ApiRoutes.signInWithFacebook,
            query: {'\$populate': 'business'},
            body: {
              "accessToken": facebookLoginResult.accessToken.token,
              "fcmId": fcmId
            },
            isAuthNeeded: false);

        await facebookLogin.logOut();

        if (resultMap.data['accessToken'] != null) {
          SharedPreferenceHelper.storeAccessToken(
              resultMap.data['accessToken']);
          final userResponse = UserResponse.fromJson(resultMap.data);
          SharedPreferenceHelper.storeUser(user: userResponse);
          final userController = Get.find<UserController>();
          userController.updateUser(userResponse.user);
          AuthHelper.checkUserLevel();
          return null;
        } else {
          return SocialSignInResponse.fromJson(resultMap.data);
        }
      default:
        return null;
    }
  }

  ///
  /// Normal user Apple login
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  /// If cancelled it will return null
  ///
  static Future<SocialSignInResponse?> userLoginWithApple() async {
    final fcmId = await FirebaseMessaging.instance.getToken();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        // TODO: set client id and redirect url

        webAuthenticationOptions:
            WebAuthenticationOptions(clientId: '', redirectUri: Uri.parse('')),
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final resultMap = await ApiCall.post(ApiRoutes.signInWithApple,
          query: {'\$populate': 'business'},
          body: {"accessToken": credential.identityToken, "fcmId": fcmId},
          isAuthNeeded: false);

      if (resultMap.data['accessToken'] != null) {
        SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
        final userResponse = UserResponse.fromJson(resultMap.data);
        SharedPreferenceHelper.storeUser(user: userResponse);
        final userController = Get.find<UserController>();
        userController.updateUser(userResponse.user);
        AuthHelper.checkUserLevel();
        return null;
      } else {
        return SocialSignInResponse.fromJson(resultMap.data);
      }
    } catch (e) {
      if (e is SignInWithAppleAuthorizationException) {
        switch (e.code) {
          case AuthorizationErrorCode.canceled:
            return null;
          default:
            throw 'Unable to login with apple';
        }
      }
      throw e.toString();
    }
  }

  ///
  /// Normal user sign up
  /// The [name] is for name, [phone] is for mobile number
  /// The [password] is for password and optional [email]
  /// After success it will send otp to phone number and redirects to [OtpVerificationOtpPage.routeName]
  /// On error it will throw [RestError]
  ///
  static Future<Map<String, dynamic>> userSignUpWithPhone(
      String name, String phone, String password,
      {String? email}) async {
    // final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    // final fcmId = await firebaseMessaging.getToken();
    final resultMap = await ApiCall.post(ApiRoutes.signInWithPhone,
        body: {
          if (email?.isNotEmpty ?? false) "email": email,
          "password": password,
          "role": 1,
          "name": name,
          'phone': phone
          // 'fcmId': fcmId
        },
        isAuthNeeded: false);

    log("OTP ${resultMap.data['otp']}");
    // SnackBarHelper.show("OTP ${resultMap.data['otp']}", "");
    return resultMap.data;
  }

  ///
  /// Verify signup OTP
  /// The [phone] is for phone number, [otp] is for entered otp
  /// After success it will check for pincode is empty or not. If empty or null it will redirects to [ChooseLocationPage.routeName]
  /// On error it will throw [RestError]
  ///
  static Future<UserResponse> verifySignUpOtp(
    Map<String, dynamic> body,
  ) async {
    final resultMap =
        await ApiCall.post(ApiRoutes.user, body: body, isAuthNeeded: false);

    SharedPreferenceHelper.storeAccessToken(resultMap.data['accessToken']);
    final userResponse = UserResponse.fromJson(resultMap.data);
    SharedPreferenceHelper.storeUser(user: userResponse);
    final userController = Get.find<UserController>();
    userController.updateUser(userResponse.user);
    AuthHelper.checkUserLevel();
    return userResponse;
  }

  ///
  /// Update pin code of user
  /// The [pincode] is for entered pin code
  /// After success it will redirects to [UserDashboardPage.routeName]
  /// On error it will throw [RestError]
  ///
  static Future<UserDatum> updateUserPinCode(String pinCode) async {
    final resultMap = await ApiCall.patch(
      ApiRoutes.user,
      id: SharedPreferenceHelper.user!.user!.id,
      body: {"pinCode": pinCode},
      query: {'\$populate': 'business'},
    );
    final userResponse = UserDatum.fromJson(resultMap.data);
    final user = SharedPreferenceHelper.user;
    user!.user = userResponse;
    SharedPreferenceHelper.storeUser(user: user);
    final userController = Get.find<UserController>();
    userController.updateUser(user.user);
    return userResponse;
  }

  ///
  /// Checks the user on-boarding
  ///
  static Future<void> checkUserLevel() async {
    UserResponse? user = SharedPreferenceHelper.user;
    if (user != null) {
      // if (user.user!.phone?.isEmpty ?? true) {
      //   Get.offAllNamed(OtpVerificationPage.routeName);
      // } else if (user.pinCode?.isEmpty ?? true) {
      //   Get.offAllNamed(ChooseLocationPage.routeName);
      // } else {
      //   Get.offAllNamed(DashboardPage.routeName);
      // }
    } else {
      Get.offAllNamed(IntroPage.routeName);
    }
  }

  static Future<Map<String, dynamic>> checkForgotUser(String field) async {
    final result = await ApiCall.get(ApiRoutes.checkForgotUser, query: {
      if (GetUtils.isEmail(field)) 'email': field,
      if (GetUtils.isPhoneNumber(field)) 'phone': field
    });
    return result.data;
  }

  static Future<Map<String, dynamic>> sendResetOtp(
      String userId, bool isEmailChecked) async {
    final result = await ApiCall.post(ApiRoutes.requestResetToken,
        body: {'user': userId, 'type': isEmailChecked ? 'email' : 'phone'});
    log('sendResetOtp ${result.data}');
    return result.data;
  }

  static Future<Map<String, dynamic>> getResetToken(
      String otp, String user) async {
    final result = await ApiCall.patch(ApiRoutes.requestResetToken,
        body: {'otp': otp, 'user': user});
    return result.data;
  }

  static Future<Map<String, dynamic>> changePassword(
      String password, String userId, String _token) async {
    SharedPreferenceHelper.storeAccessToken(_token);
    final result = await ApiCall.patch(ApiRoutes.user,
        id: userId, body: {'password': password});
    SharedPreferenceHelper.storeAccessToken("");
    return result.data;
  }

  static Future<String?> refreshAccessToken() async {
    final String? oldToken = SharedPreferenceHelper.accessToken;
    if (oldToken?.isEmpty ?? true) return null;
    final result = await ApiCall.post('authentication',
        basePath: ApiRoutes.baseUrl,
        isAuthNeeded: false,
        body: {'accessToken': oldToken, 'strategy': 'jwt'});
    final String accessToken = result.data['accessToken'];
    final user = UserResponse.fromJson(result.data);
    SharedPreferenceHelper.storeUser(user: user);
    // UserBloc().add(LoadUserEvent(user: user.user));
    return accessToken;
  }

  static Future<UserDatum?> updateUser(Map<String, dynamic> body) async {
    final u = SharedPreferenceHelper.user;
    if (u!.user == null) return null;
    final result =
        await ApiCall.patch(ApiRoutes.user, id: u.user!.id, body: body);
    final user = UserDatum.fromJson(result.data);
    u.user = user;
    SharedPreferenceHelper.storeUser(user: u);

    final userController = Get.find<UserController>();
    userController.updateUser(user);
    return user;
  }
}

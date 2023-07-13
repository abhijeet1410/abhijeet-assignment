import 'package:assignment_pay/data_models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const USER_KEY = 'user';
  static const LOCATION_KEY = 'location';

  static SharedPreferences? preferences;

  static void clear() {
    preferences?.clear();
  }

  static void logout() {
    preferences?.remove(USER_KEY);
  }

  //
  // static void storeLocation(List<double> coordinates) {
  //   preferences?.setString(LOCATION_KEY,
  //       json.encode(List<dynamic>.from(coordinates.map((x) => x))));
  // }
  //
  // static List<double> get location =>
  //     preferences?.getString(LOCATION_KEY)?.isEmpty ?? true
  //         ? []
  //         : List<double>.from(
  //                 json.decode(preferences?.getString(LOCATION_KEY) ?? ''))
  //             .map((x) => x)
  //             .toList();

  static void storeUser({UserResponse? user, String? response}) {
    if (user != null) {
      preferences?.setString(USER_KEY, userResponseToJson(user));
    } else {
      if (response == null || response.isEmpty) {
        throw 'No value to store. Either a User object or a String response is required to store in preference.';
      } else {
        preferences?.setString(USER_KEY, response);
      }
    }
  }

  static UserResponse? get user => preferences?.getString(USER_KEY) == null
      ? null
      : userResponseFromJson(preferences?.getString(USER_KEY) ?? '');
}

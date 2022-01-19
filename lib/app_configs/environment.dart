///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod'
      ? 'https://api.ausicare.smarttersstudio.com'
      : 'https://api.ausicare.smarttersstudio.com';

  static const googleClientId = environment == 'prod'
      ? '681620975257-tbfnmcf058mutbln18rra1kv2riinn2t.apps.googleusercontent.com'
      : '681620975257-tbfnmcf058mutbln18rra1kv2riinn2t.apps.googleusercontent.com';

  static const fontFamily = 'Gilory';

  static const mapApiKey = 'AIzaSyA0MFZxHOCAO0Suy9MRWS0wIg6_FFynHvg';

  static const razorPayName = "Ausicare";

  static const razorPayKey = environment == 'prod'
      ? 'rzp_test_pC6qqqbP83w7bs'
      : 'rzp_test_pC6qqqbP83w7bs';

  static const razorPayKeySecret = 'RDgDRqnLU0JdfFjV5ZO6JTWc';
}

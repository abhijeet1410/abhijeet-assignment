///
/// Created by Sunil Kumar from Boiler plate
///
mixin Environment {
  static const String environment =
      String.fromEnvironment("env", defaultValue: 'dev');

  static const String baseApiUrl = environment == 'prod' ? '' : '';

  static const googleClientId = environment == 'prod' ? ' ' : ' ';

  static const fontFamily = 'Gilory';

  static const mapApiKey = ' ';

  static const razorPayKey = environment == 'prod' ? ' ' : ' ';
}

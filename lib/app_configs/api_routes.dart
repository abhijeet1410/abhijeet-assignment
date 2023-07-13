import 'environment.dart';

mixin ApiRoutes {
  static const baseUrl = Environment.baseApiUrl;
  static const v1 = 'v1';
  static const upload = '$v1/upload';
}

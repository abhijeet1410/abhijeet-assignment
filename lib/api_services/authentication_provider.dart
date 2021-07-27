import 'package:get/get.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AuthenticationProvider extends GetConnect {
  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/$id');

  // Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', data);
// Post request with File
// Future<Response<CasesModel>> postCases(List<int> image) {
//   final form = FormData({
//     'file': MultipartFile(image, filename: 'avatar.png'),
//     'otherFile': MultipartFile(image, filename: 'cover.png'),
//   });
//   return post('http://youapi/users/upload', form);
// }

}

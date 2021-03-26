import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mobile_template/app_configs/api_routes.dart';
import 'package:flutter_mobile_template/app_configs/environment.dart';
import 'package:flutter_mobile_template/data_models/rest_error.dart';
import 'package:flutter_mobile_template/pages/authenticaton/pages/intro/intro_page.dart';
import 'package:flutter_mobile_template/utils/shared_preference_helper.dart';
import 'package:get/route_manager.dart';
import 'package:http_parser/http_parser.dart' as p;

///
/// Created by Sunil Kumar from Boiler plate
///
enum RequestMethod { get, create, patch, remove }

class ApiCall {
  static Dio _dio = Dio();

  static Future<Response> _generalApiCall(
    String path,
    RequestMethod requestMethod, {
    String id = '',
    String basePath = Environment.baseApiUrl,
    Map<String, dynamic> query = const {},
    dynamic body = const {},
    bool isAuthNeeded = true,
  }) async {
    _dio.options.contentType = 'application/json';
    if (isAuthNeeded && SharedPreferenceHelper.accessToken != null)
      _dio.options.headers['Authorization'] =
          SharedPreferenceHelper.accessToken;
    try {
      Response response;
      switch (requestMethod) {
        case RequestMethod.get:
          response =
              await _dio.get('$basePath/$path/$id', queryParameters: query);
          break;
        case RequestMethod.create:
          response = await _dio.post('$basePath/$path/$id',
              data: body, queryParameters: query);
          break;
        case RequestMethod.patch:
          response = await _dio.patch('$basePath/$path/$id',
              data: body, queryParameters: query);
          break;
        case RequestMethod.remove:
          response =
              await _dio.delete('$basePath/$path/$id', queryParameters: query);
          break;
        default:
          throw ArgumentError('Invalid RequestMethod $requestMethod');
      }
      return response;
    } on SocketException {
      throw NoInternetError();
    } catch (error, s) {
      log('ERROR URL $basePath/$path/$id', error: '$error', stackTrace: s);
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {
            Get.offAndToNamed(IntroPage.routeName);
          }
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  static Future<Response> get(
    String path, {
    String id = '',
    String basePath = Environment.baseApiUrl,
    Map<String, dynamic> query = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.get,
        id: id, basePath: basePath, query: query, isAuthNeeded: isAuthNeeded);
  }

  static Future<Response> post(
    String path, {
    String id = '',
    String basePath = Environment.baseApiUrl,
    Map<String, dynamic> query = const {},
    dynamic body = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.create,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body);
  }

  static Future<Response> patch(
    String path, {
    String id = '',
    String basePath = Environment.baseApiUrl,
    Map<String, dynamic> query = const {},
    Map<String, dynamic> body = const {},
    bool isAuthNeeded = true,
  }) async {
    return _generalApiCall(path, RequestMethod.patch,
        id: id,
        basePath: basePath,
        query: query,
        isAuthNeeded: isAuthNeeded,
        body: body);
  }

  static Future<Response> delete(String path,
      {String id = '',
      String basePath = Environment.baseApiUrl,
      Map<String, dynamic> query = const {}}) async {
    return _generalApiCall(path, RequestMethod.remove,
        id: id, basePath: basePath, query: query, isAuthNeeded: true);
  }

  /// Single file upload
  static Future<String?> singleFileUpload(File file,
      {String path = ApiRoutes.upload}) async {
    try {
      if (SharedPreferenceHelper.accessToken == null ||
          SharedPreferenceHelper.accessToken!.isEmpty) {
        return null;
      } else {
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.accessToken;
        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap({
              "photo": await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last,
                  contentType: p.MediaType('image', 'jpeg'))
            }));
        return response.data['file'];
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if ((error as dynamic).response == null) {
        throw NoInternetError();
      }
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }

  /// Multiple file upload
  static Future<List<String>?> multiFileUpload(List<File> files,
      {String path = ApiRoutes.upload}) async {
    try {
      if (SharedPreferenceHelper.accessToken == null ||
          SharedPreferenceHelper.accessToken!.isEmpty) {
        return null;
      } else {
        final Dio dio = Dio();
        dio.options.headers['Authorization'] =
            SharedPreferenceHelper.accessToken;

        Map<String, MultipartFile> body = {};

        for (int i = 0; i < files.length; i++) {
          body['photo$i'] = await MultipartFile.fromFile(files[i].path,
              contentType: p.MediaType('image', 'jpeg'));
        }

        Response response = await dio.post('${ApiRoutes.baseUrl}/$path',
            data: FormData.fromMap(body));

        return List<String>.from(response.data.map((x) => x));
      }
    } on SocketException {
      throw NoInternetError();
    } catch (error) {
      if (error is DioError) {
        if (error.response.statusCode == 502) {
          throw 'Server unreachable';
        } else {
          final restError = RestError.fromJson(error.response.data);
          if (restError.code == 401) {}
          throw restError;
        }
      } else {
        throw error.toString();
      }
    }
  }
}

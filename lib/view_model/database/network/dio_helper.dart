import 'package:dio/dio.dart';
import 'package:pro_mina_gallery/view_model/database/network/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response<dynamic>> getData(
      {required String url,  Map<String, dynamic>? query, String? token}) async {
    dio.options.headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${token?? ''}'};
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response<dynamic>> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer ${token?? ''}'};
    return await dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response<dynamic>> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token,
  }) async {
    dio.options.headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};
    return await dio.put(url, queryParameters: query, data: data);
  }
}

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shaudan_b2b/cores/interceptors/dio_interceptors.dart';
import 'package:shaudan_b2b/res/app_url/app_url.dart';

class Api {
  final Dio _dio = Dio();

  Api() {
    _dio.options.baseUrl = AppUrl.baseUrl;
    _dio.options.connectTimeout = const Duration(
      seconds: 10,
    ); //10s
    _dio.options.receiveTimeout = const Duration(
      seconds: 10,
    ); // 10s
    _dio.options.headers = {
      // accept every thing
      "Accept": "*/*",
      "Content-Type": "application/json",
    }; // headers
    _dio.interceptors.add(DioInterceptors());
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ), // PrettyDioLogger()
    ); // add()
    // what to if time
  } // Api()

  Dio get sendRequest => _dio; // sendRequest
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
  }); // ApiResponse()

  factory ApiResponse.fromResponse(Response response) {
    // ************************************************
    // response.data
    // in nodebackend like this
    // res.json({
    //     success: true || false,
    //     data: data || null,
    //     message: "Successfully message" || "Unknown Error,
    //   });
    // ************************************************

    final data = response.data as Map<String, dynamic>;

    return ApiResponse(
      success: data['success'] as bool,
      data: data['data'],
      message: data['message'] ?? "Unknown Error",
    ); // ApiResponse()
  } // ApiResponse.fromResponse()
}

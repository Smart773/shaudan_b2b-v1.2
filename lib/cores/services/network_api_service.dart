import 'dart:async';
import 'package:shaudan_b2b/cores/api/api.dart';
import 'package:shaudan_b2b/cores/app_exception/app_exception.dart';
import 'package:shaudan_b2b/cores/services/base_api_service.dart';

import 'package:dio/dio.dart' as dio;

class NetworkApiSerive extends BaseApiService {
  dynamic returnResponse(dio.Response response) {
    ApiResponse responseJson = ApiResponse.fromResponse(response);
    if (responseJson.success == false) {
      throw FetchDataExceptions("${responseJson.message} ");
    }
    switch (response.statusCode) {
      case 200:
        return responseJson.data;
      case 400:
        throw InvalidUrlExceptions("Invalid Url");
      default:
        throw FetchDataExceptions(
            "Communtcation problem status code ${response.statusCode}");
    }
  }

  @override
  Future getApi(String url) async {
    dynamic responsJson;
    try {
      final api = Api();
      dio.Response response = await api.sendRequest.get(url);
      responsJson = returnResponse(response);
      return responsJson;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        responsJson = returnResponse(e.response!);
      } else {
        throw FetchDataExceptions(e.message);
      }
    }
  } //getApi

  @override
  Future postApi(data, String url) async {
    // TODO: implement postApi
    dynamic responsJson;
    try {
      final api = Api();
      dio.Response response = await api.sendRequest.post(url, data: data);

      responsJson = returnResponse(response);
      return responsJson;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        responsJson = returnResponse(e.response!);
      } else {
        throw FetchDataExceptions(e.message);
      }
    }
    // throw UnimplementedError();
  }

  @override
  Future deleteApi(String url) async {
    dynamic responsJson;
    try {
      final api = Api();
      dio.Response response = await api.sendRequest.delete(url);
      responsJson = returnResponse(response);
      return responsJson;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        responsJson = returnResponse(e.response!);
      } else {
        throw FetchDataExceptions(e.message);
      }
    }
  }

  @override
  Future patchApi(data, String url) async{
    dynamic responsJson;
    try {
      final api = Api();
      dio.Response response = await api.sendRequest.patch(url, data: data);

      responsJson = returnResponse(response);
      return responsJson;
    } on dio.DioError catch (e) {
      if (e.response != null) {
        responsJson = returnResponse(e.response!);
      } else {
        throw FetchDataExceptions(e.message);
      }
    }
  } //postApi
}// NetworkApiSerive



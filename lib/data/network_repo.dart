import 'package:dio/dio.dart';
import 'package:floward_task/model/responses/api_response.dart';
import 'package:floward_task/remote/dio/api_client.dart';
import 'package:floward_task/remote/exception/api_error_handler.dart';
import 'package:floward_task/utils/app_constants.dart';

class NetworkRepo {
  Future<ApiResponse> getUsers() async {
    Response response = await ApiClient().get(AppConstants.usersPath);
    try {
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getPosts() async {
    Response response = await ApiClient().get(AppConstants.postsPath);
    try {
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

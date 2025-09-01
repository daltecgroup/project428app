import 'dart:convert';
import 'package:get/get.dart';
import '../models/User.dart';
import '../../utils/helpers/get_storage_helper.dart';
import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    _providerInit();
  }

  Future<Response<List<User>>> getUsers() async {
    final Response response = await get('/users');
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<User> users = jsonList
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: users,
        headers: response.headers,
        request: response.request,
      );
    } else {
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: null,
        headers: response.headers,
        request: response.request,
      );
    }
  }

  Future<Response> createUser(dynamic data) async {
    return await post('/users', data);
  }

  Future<Response> updateUser(String id, dynamic data) async {
    return await put('/users/$id', data);
  }

  Future<Response> updateUserProfile(String id, dynamic data) async {
    return await put('/users/$id/profile', data);
  }

  Future<Response> softDeleteUser(String id) async {
    return await delete('/users/$id');
  }

  Future<Response<Map<String, List<User>>>> syncUsers(
    int latest,
    List<String> idList,
  ) async {
    final Response response = await post(
      '/users/sync',
      json.encode({'latest': latest, 'idList': idList}),
    );
    if (response.isOk && response.body is Map<String, dynamic>) {
      Map<String, List<User>> body = {
        'toAdd': (response.body['toAdd'] as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList(),
        'toUpdate': (response.body['toUpdate'] as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList(),
        'toDelete': (response.body['toDelete'] as List<dynamic>)
            .map((e) => User.fromJson(e))
            .toList(),
      };
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: body,
        headers: response.headers,
        request: response.request,
      );
    } else {
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: null,
        headers: response.headers,
        request: response.request,
      );
    }
  }

  void _providerInit() {
    httpClient.baseUrl = AppConstants.CURRENT_BASE_API_URL;
    httpClient.timeout = const Duration(seconds: 5);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] =
          'Bearer ${box.getValue(AppConstants.KEY_USER_TOKEN) ?? ''}';
      return request;
    });
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.status.isForbidden || response.unauthorized) {
        Get.offNamed(Routes.AUTH);
        unauthorizedSnackbar();
      }
      return response;
    });
  }
}

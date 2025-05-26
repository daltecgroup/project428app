import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import '../services/auth_service.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    // httpClient.baseUrl = '$base/api/v1';
    httpClient.timeout = const Duration(seconds: 5); // 5 seconds

    // Add a request modifier to attach the access token
    // httpClient.addRequestModifier<dynamic>((request) async {
    //   final AuthService authService = Get.find<AuthService>();
    //   // Only add token if it's not a login or refresh token request
    //   if (!request.url.path.contains('/auth/login') &&
    //       !request.url.path.contains('/auth/refresh')) {
    //     if (authService.accessToken.value.isNotEmpty) {
    //       request.headers['Authorization'] =
    //           'Bearer ${authService.accessToken.value}';
    //     }
    //   }
    //   return request;
    // });

    // Add a response modifier to handle 401 Unauthorized errors
    httpClient.addResponseModifier((request, response) async {
      final AuthService authService = Get.find<AuthService>();

      if (response.statusCode == 401) {
        // Check if the original request was not a refresh token request
        if (!request.url.path.contains('/auth/refresh')) {
          print('401 Unauthorized. Attempting to refresh token...');
          bool refreshed =
              await authService
                  .checkAndRefreshToken(); // Access private method for simplicity in this example

          if (refreshed) {
            // If token was refreshed, retry the original request
            final newAccessToken = authService.accessToken.value;
            request.headers['Authorization'] = 'Bearer $newAccessToken';
            // Important: You need to re-execute the request here.
            // GetConnect doesn't have a direct 'retry' mechanism like Dio.
            // You'll typically need to re-call the original HTTP method.
            // This requires the original APIClient method to be designed to handle this.
            // For now, we'll just return the original (401) response, assuming
            // the Auth Service will handle the retry logic at a higher level,
            // or the UI will react to the 401 after the refresh.
            // A more robust solution might involve a custom retry mechanism within the service.
            // For now, let's just make sure the token is updated for future requests.
            print(
              'Token refreshed, but original request was not automatically retried.',
            );
            // A better pattern for retry: The service method that made the original call
            // should catch the 401 and then, after refreshing, retry itself.
            // Or you can create a wrapper function.
            return response; // Return the original 401 response for now
          } else {
            // If refresh failed, force logout
            await authService.logout();
            return response; // Return the 401 response
          }
        }
      }
      return response; // Return the response as is
    });
  }

  // method to set base URL dynamically
  AuthProvider setBaseUrl(String newBase) {
    httpClient.baseUrl = '$newBase/api/v1';
    return this;
  }

  // Example of a protected endpoint
  Future<Response> getProtectedData() async {
    return await get('/protected-data');
  }

  // Example of an unprotected endpoint
  Future<Response> registerUser(Map<String, dynamic> data) async {
    return await post('/auth/register', data);
  }
}

import 'package:abg_pos_app/app/data/providers/user_outlet_provider.dart';
import 'package:get/get.dart';

import '../models/Outlet.dart';

class UserOutletRepository extends GetxController {
  UserOutletRepository({required this.provider});
  final UserOutletProvider provider;

  Future<Outlet?> getCurrentOutlet() async {
    final Response response = await provider.getCurrentOutlet();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch current user outlet: ${response.statusCode} - ${response.body['message'] ?? ''}',
      );
    }
    return response.body['userOutlet'];
  }
}

import 'package:get/get.dart';
import '../models/OutletInventory.dart';
import '../providers/outlet_inventory_provider.dart';

class OutletInventoryRepository extends GetxController {
  OutletInventoryRepository({required this.provider});
  final OutletInventoryProvider provider;

  Future<OutletInventory?> getOutletInventory(String outletId) async {
    final Response response = await provider.getOutletInventory(outletId);
    if (response.hasError) {
      throw Exception(
        'Failed to fetch outlet inventory: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body;
  }
}

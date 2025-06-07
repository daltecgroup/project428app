import 'package:get/get.dart';
import 'package:project428app/app/data/models/product.dart';

class NewSalesItem {
  final Product product;
  RxInt qty = 1.obs;
  String note = '';
  String type = 'regular';
  List topping = [];

  NewSalesItem({required this.product});

  void setNote(String note) {
    note = note;
  }

  void addOne() {
    if (qty >= 0) {
      qty++;
    } else {
      qty.value = 0;
    }
  }

  void removeOne() {
    if (qty > 0) {
      qty--;
    } else {
      qty.value = 0;
    }
  }

  int getTotalPriceAfterDiscount() {
    return (product.price - ((product.discount / 100) * product.price).ceil()) *
        qty.value;
  }

  int getPriceAfterDiscount() {
    return product.price - ((product.discount / 100) * product.price).ceil();
  }

  int getSaving() {
    return ((product.discount / 100) * product.price).ceil();
  }

  int getTotalSaving() {
    return ((product.discount / 100) * product.price).ceil() * qty.value;
  }
}

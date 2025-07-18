class BundleCategory {
  final String menuCategoryId;
  double qty;

  BundleCategory({required this.menuCategoryId, required this.qty});

  factory BundleCategory.fromJson(Map<String, dynamic> json) {
    return BundleCategory(
      menuCategoryId: json['menuCategoryId'],
      qty: double.parse(json['qty'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuCategoryId': menuCategoryId, 'qty': qty};
  }

  void addQty() {
    qty++;
  }

  void substractQty() {
    if (qty > 0) {
      qty--;
    } else {
      qty = 0;
    }
  }
}

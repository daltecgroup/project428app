import 'Address.dart';

class SaleOutlet {
  final String outletId, name;
  final Address address;

  SaleOutlet({
    required this.outletId,
    required this.name,
    required this.address,
  });

  factory SaleOutlet.fromJson(Map<String, dynamic> json) {
    return SaleOutlet(
      outletId: json['outletId'],
      name: json['name'],
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'outletId': outletId, 'name': name, 'address': address.toJson()};
  }
}

class SaleOperator {
  final String operatorId, name;

  SaleOperator({required this.operatorId, required this.name});

  factory SaleOperator.fromJson(Map<String, dynamic> json) {
    return SaleOperator(operatorId: json['operatorId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'operatorId': operatorId, 'name': name};
  }
}

class SalePayment {
  final String method;
  final String? evidenceUrl;

  SalePayment({required this.method, required this.evidenceUrl});

  factory SalePayment.fromJson(Map<String, dynamic> json) {
    return SalePayment(
      method: json['method'],
      evidenceUrl: json['evidenceUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'method': method, 'evidenceUrl': evidenceUrl};
  }
}

class SaleInvoicePrintHistory {
  final String userId;
  final DateTime printedAt;

  SaleInvoicePrintHistory({required this.userId, required this.printedAt});

  factory SaleInvoicePrintHistory.fromJson(Map<String, dynamic> json) {
    return SaleInvoicePrintHistory(
      userId: json['userId'],
      printedAt: DateTime.parse(json['printedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'printedAt': printedAt.toIso8601String()};
  }
}

class SaleIngredientUsed {
  final String ingredientId;
  final String? name, unit;
  final double qty, expense;

  SaleIngredientUsed({
    required this.ingredientId,
    required this.name,
    required this.unit,
    required this.qty,
    required this.expense,
  });

  factory SaleIngredientUsed.fromJson(Map<String, dynamic> json) {
    return SaleIngredientUsed(
      ingredientId: json['ingredientId'],
      name: json['name'],
      unit: json['unit'],
      qty: double.parse(json['qty'].toString()),
      expense: double.parse(json['expense'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'name': name,
      'unit': unit,
      'qty': qty,
      'expense': expense,
    };
  }
}

class SaleItemSingleAddon {
  final String addonId, name;
  final double qty, price;

  SaleItemSingleAddon({
    required this.addonId,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory SaleItemSingleAddon.fromJson(Map<String, dynamic> json) {
    return SaleItemSingleAddon(
      addonId: json['addonId'],
      name: json['name'],
      qty: double.parse(json['qty'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'addonId': addonId, 'name': name, 'qty': qty, 'price': price};
  }
}

class SaleItemSingle {
  final String menuId, name;
  final String? notes;
  final double qty, price, discount;
  final List<SaleItemSingleAddon> addons;

  SaleItemSingle({
    required this.menuId,
    required this.name,
    required this.notes,
    required this.qty,
    required this.price,
    required this.discount,
    required this.addons,
  });

  factory SaleItemSingle.fromJson(Map<String, dynamic> json) {
    return SaleItemSingle(
      menuId: json['menuId'],
      name: json['name'],
      notes: json['notes'],
      qty: double.parse(json['qty'].toString()),
      price: double.parse(json['price'].toString()),
      discount: double.parse(json['discount'].toString()),
      addons: (json['addons'] as List)
          .map((e) => SaleItemSingleAddon.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'name': name,
      'notes': notes,
      'qty': qty,
      'price': price,
      'discount': discount,
      'addons': addons.map((e) => e.toJson()).toList(),
    };
  }

  double get getDiscount {
    if (discount == 0) return 0;
    return discount / 100 * price;
  }

  double get getTotalDiscount {
    return getDiscount * qty;
  }
}

class SaleBundleMenuItem {
  final String menuId, name;
  final double qty, price;

  SaleBundleMenuItem({
    required this.menuId,
    required this.name,
    required this.qty,
    required this.price,
  });

  factory SaleBundleMenuItem.fromJson(Map<String, dynamic> json) {
    return SaleBundleMenuItem(
      menuId: json['menuId'],
      name: json['name'],
      qty: double.parse(json['qty'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'name': name, 'qty': qty, 'price': price};
  }
}

class SaleItemBundle {
  final String menuBundleId, name;
  final double qty, price;
  final List<SaleBundleMenuItem> items;

  SaleItemBundle({
    required this.menuBundleId,
    required this.name,
    required this.qty,
    required this.price,
    required this.items,
  });

  factory SaleItemBundle.fromJson(Map<String, dynamic> json) {
    return SaleItemBundle(
      menuBundleId: json['menuBundleId'],
      name: json['name'],
      qty: double.parse(json['qty'].toString()),
      price: double.parse(json['price'].toString()),
      items: (json['items'] as List)
          .map((e) => SaleBundleMenuItem.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menuBundleId': menuBundleId,
      'name': name,
      'qty': qty,
      'price': price,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}

class SalePromoItem {
  final String menuId, name;
  final double qty;

  SalePromoItem({required this.menuId, required this.name, required this.qty});

  factory SalePromoItem.fromJson(Map<String, dynamic> json) {
    return SalePromoItem(
      menuId: json['menuId'],
      name: json['name'],
      qty: double.parse(json['qty'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'menuId': menuId, 'name': name, 'qty': qty};
  }
}

class Sale {
  final String id, code;
  final bool isValid;
  final SaleOutlet outlet;
  final SaleOperator operator;
  final List<SaleItemSingle> itemSingle;
  final List<SaleItemBundle> itemBundle;
  final List<SalePromoItem> itemPromo;
  final double totalPrice, totalPaid;
  final SalePayment payment;
  final List<SaleInvoicePrintHistory> invoicePrintHistory;
  final List<SaleIngredientUsed> ingredientUsed;
  final DateTime createdAt, updatedAt;

  Sale({
    required this.id,
    required this.code,
    required this.isValid,
    required this.outlet,
    required this.operator,
    required this.itemSingle,
    required this.itemBundle,
    required this.itemPromo,
    required this.totalPrice,
    required this.totalPaid,
    required this.payment,
    required this.invoicePrintHistory,
    required this.ingredientUsed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      code: json['code'],
      isValid: json['isValid'],
      outlet: SaleOutlet.fromJson(json['outlet']),
      operator: SaleOperator.fromJson(json['operator']),
      itemSingle: (json['itemSingle'] as List)
          .map((e) => SaleItemSingle.fromJson(e))
          .toList(),
      itemBundle: (json['itemBundle'] as List)
          .map((e) => SaleItemBundle.fromJson(e))
          .toList(),
      itemPromo: (json['itemPromo'] as List)
          .map((e) => SalePromoItem.fromJson(e))
          .toList(),
      totalPrice: double.parse(json['totalPrice'].toString()),
      totalPaid: double.parse(json['totalPaid'].toString()),
      payment: SalePayment.fromJson(json['payment']),
      invoicePrintHistory: (json['invoicePrintHistory'] as List)
          .map((e) => SaleInvoicePrintHistory.fromJson(e))
          .toList(),
      ingredientUsed: (json['ingredientUsed'] as List)
          .map((e) => SaleIngredientUsed.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'isValid': isValid,
      'outlet': outlet.toJson(),
      'operator': operator.toJson(),
      'itemSingle': itemSingle.map((e) => e.toJson()).toList(),
      'itemBundle': itemBundle.map((e) => e.toJson()).toList(),
      'itemPromo': itemPromo.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'totalPaid': totalPaid,
      'payment': payment.toJson(),
      'invoicePrintHistory': invoicePrintHistory
          .map((e) => e.toJson())
          .toList(),
      'ingredientUsed': ingredientUsed.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  // get total change
  double get totalChange {
    return totalPaid - totalPrice;
  }

  double get totalDiscount {
    return itemSingle.fold(0, (prev, item) => prev + item.getTotalDiscount);
  }

  int get itemCount {
    return itemSingle.fold(0, (value, item) => value + item.qty.toInt()) +
        itemBundle.fold(0, (value, item) => value + item.items.length).toInt() +
        itemPromo.length;
  }
}

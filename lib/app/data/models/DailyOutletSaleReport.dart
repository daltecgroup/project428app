class DOSROutlet {
  final String outletId, name, code;

  DOSROutlet({required this.outletId, required this.name, required this.code});

  factory DOSROutlet.fromJson(Map<String, dynamic> json) {
    return DOSROutlet(
      outletId: json['outletId'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'outletId': outletId, 'name': name, 'code': code};
  }
}

class DOSRItemSold {
  final String itemId, name, type;
  final double qtySold, totalRevenue;

  DOSRItemSold({
    required this.itemId,
    required this.name,
    required this.type,
    required this.qtySold,
    required this.totalRevenue,
  });

  factory DOSRItemSold.fromJson(Map<String, dynamic> json) {
    return DOSRItemSold(
      itemId: json['itemId'],
      name: json['name'],
      type: json['type'],
      qtySold: double.parse(json['qtySold'].toString()),
      totalRevenue: double.parse(json['totalRevenue'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'itemId': itemId,
      'name': name,
      'type': type,
      'qtySold': qtySold,
      'totalRevenue': totalRevenue,
    };
  }
}

class DailyOutletSaleReport {
  final String id, date;
  final DOSROutlet outlet;
  final List<DOSRItemSold> itemSold;
  final double totalSale, totalExpense, saleComplete;
  final DateTime createdAt, updatedAt;

  DailyOutletSaleReport({
    required this.id,
    required this.date,
    required this.outlet,
    required this.itemSold,
    required this.totalSale,
    required this.totalExpense,
    required this.saleComplete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyOutletSaleReport.fromJson(Map<String, dynamic> json) {
    var itemSoldList = <DOSRItemSold>[];
    if (json['itemSold'] != null) {
      itemSoldList = List<DOSRItemSold>.from(
        (json['itemSold'] as List).map((item) => DOSRItemSold.fromJson(item)),
      );
    }

    return DailyOutletSaleReport(
      id: json['id'],
      date: json['date'],
      outlet: DOSROutlet.fromJson(json['outlet']),
      itemSold: itemSoldList,
      totalSale: double.parse(json['totalSale'].toString()),
      totalExpense: double.parse(json['totalExpense'].toString()),
      saleComplete: double.parse(json['saleComplete'].toString()),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'outlet': outlet.toJson(),
      'itemSold': itemSold.map((item) => item.toJson()).toList(),
      'totalSale': totalSale,
      'totalExpense': totalExpense,
      'saleComplete': saleComplete,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  int get singleItemSold {
    var count = 0;

    for (var item in itemSold) {
      if (item.type == 'menu_single') {
        count = count + item.qtySold.round();
      }
    }

    return count;
  }

  int get bundleItemSold {
    var count = 0;

    for (var item in itemSold) {
      if (item.type == 'bundle') {
        count = count + item.qtySold.round();
      }
    }

    return count;
  }
}

class DashboardResponse {
  final String message;
  final DashboardData data;

  DashboardResponse({
    required this.message,
    required this.data,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      message: json['message'] ?? '',
      data: DashboardData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class DashboardData {
  final PeriodStats today;
  final PeriodStats thisMonth;
  final List<InventoryAlert> inventoryAlerts;

  DashboardData({
    required this.today,
    required this.thisMonth,
    required this.inventoryAlerts,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      today: PeriodStats.fromJson(json['today']),
      thisMonth: PeriodStats.fromJson(json['thisMonth']),
      inventoryAlerts: (json['inventoryAlerts'] as List?)
              ?.map((e) => InventoryAlert.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'today': today.toJson(),
      'thisMonth': thisMonth.toJson(),
      'inventoryAlerts': inventoryAlerts.map((e) => e.toJson()).toList(),
    };
  }
}

class PeriodStats {
  final PeriodRange? range;
  final Financials financials;
  final Operations operations;
  final List<TopProduct> topProducts;

  PeriodStats({
    this.range,
    required this.financials,
    required this.operations,
    required this.topProducts,
  });

  factory PeriodStats.fromJson(Map<String, dynamic> json) {
    return PeriodStats(
      range: json['range'] != null ? PeriodRange.fromJson(json['range']) : null,
      financials: Financials.fromJson(json['financials']),
      operations: Operations.fromJson(json['operations']),
      topProducts: (json['topProducts'] as List?)
              ?.map((e) => TopProduct.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'range': range?.toJson(),
      'financials': financials.toJson(),
      'operations': operations.toJson(),
      'topProducts': topProducts.map((e) => e.toJson()).toList(),
    };
  }
}

class PeriodRange {
  final String start;
  final String end;

  PeriodRange({required this.start, required this.end});

  factory PeriodRange.fromJson(Map<String, dynamic> json) {
    return PeriodRange(
      start: json['start'] ?? '',
      end: json['end'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'start': start, 'end': end};
}

class Financials {
  final num revenue;
  final num expense;
  final num netProfit;
  final num transactions;
  final String margin;

  Financials({
    required this.revenue,
    required this.expense,
    required this.netProfit,
    required this.transactions,
    required this.margin,
  });

  factory Financials.fromJson(Map<String, dynamic> json) {
    return Financials(
      revenue: json['revenue'] ?? 0,
      expense: json['expense'] ?? 0,
      netProfit: json['netProfit'] ?? 0,
      transactions: json['transactions'] ?? 0,
      margin: json['margin'] ?? '0%',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'revenue': revenue,
      'expense': expense,
      'netProfit': netProfit,
      'transactions': transactions,
      'margin': margin,
    };
  }
}

class Operations {
  final int pendingRequests;
  final int activeOperators;
  final int activeOutlets;
  final int totalOperatorsMaster;
  final int totalOutletsMaster;

  Operations({
    required this.pendingRequests,
    required this.activeOperators,
    required this.activeOutlets,
    required this.totalOperatorsMaster,
    required this.totalOutletsMaster,
  });

  factory Operations.fromJson(Map<String, dynamic> json) {
    return Operations(
      pendingRequests: json['pendingRequests'] ?? 0,
      activeOperators: json['activeOperators'] ?? 0,
      activeOutlets: json['activeOutlets'] ?? 0,
      totalOperatorsMaster: json['totalOperatorsMaster'] ?? 0,
      totalOutletsMaster: json['totalOutletsMaster'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pendingRequests': pendingRequests,
      'activeOperators': activeOperators,
      'activeOutlets': activeOutlets,
      'totalOperatorsMaster': totalOperatorsMaster,
      'totalOutletsMaster': totalOutletsMaster,
    };
  }
}

class TopProduct {
  final String name;
  final String type;
  final num qtySold;
  final num revenueContribution;

  TopProduct({
    required this.name,
    required this.type,
    required this.qtySold,
    required this.revenueContribution,
  });

  factory TopProduct.fromJson(Map<String, dynamic> json) {
    return TopProduct(
      // Note: Di aggregation result, nama produk ada di field '_id'
      name: json['_id'] ?? 'Unknown', 
      type: json['type'] ?? 'unknown',
      qtySold: json['qtySold'] ?? 0,
      revenueContribution: json['revenueContribution'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': name,
      'type': type,
      'qtySold': qtySold,
      'revenueContribution': revenueContribution,
    };
  }
}

class InventoryAlert {
  final String? outletId;
  final String ingredientName;
  final num currentQty;
  final String unit;

  InventoryAlert({
    this.outletId,
    required this.ingredientName,
    required this.currentQty,
    required this.unit,
  });

  factory InventoryAlert.fromJson(Map<String, dynamic> json) {
    return InventoryAlert(
      outletId: json['outletId'],
      ingredientName: json['ingredientName'] ?? 'Unknown',
      currentQty: json['currentQty'] ?? 0,
      unit: json['unit'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'outletId': outletId,
      'ingredientName': ingredientName,
      'currentQty': currentQty,
      'unit': unit,
    };
  }
}
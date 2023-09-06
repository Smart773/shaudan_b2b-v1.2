class DashboardModel {
  int? totalOrders;
  int? totalPendingOrders;
  int? totalDeliveredOrders;
  int? totalCancelledOrders;
  int? todaySaleAmount;
  int? thisWeekSaleAmount;
  int? thisMonthSaleAmount;

  DashboardModel(
      {this.totalOrders,
      this.totalPendingOrders,
      this.totalDeliveredOrders,
      this.totalCancelledOrders,
      this.todaySaleAmount,
      this.thisWeekSaleAmount,
      this.thisMonthSaleAmount});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    totalOrders = json['totalOrders'];
    totalPendingOrders = json['totalPendingOrders'];
    totalDeliveredOrders = json['totalDeliveredOrders'];
    totalCancelledOrders = json['totalCancelledOrders'];
    todaySaleAmount = json['todaySaleAmount'];
    thisWeekSaleAmount = json['thisWeekSaleAmount'];
    thisMonthSaleAmount = json['thisMonthSaleAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalOrders'] = totalOrders;
    data['totalPendingOrders'] = totalPendingOrders;
    data['totalDeliveredOrders'] = totalDeliveredOrders;
    data['totalCancelledOrders'] = totalCancelledOrders;
    data['todaySaleAmount'] = todaySaleAmount;
    data['thisWeekSaleAmount'] = thisWeekSaleAmount;
    data['thisMonthSaleAmount'] = thisMonthSaleAmount;
    return data;
  }
}

class DashboardModel {
  bool? status;
  int? code;
  String? message;
  int? totalOrders;
  int? totalClient;

  DashboardModel(
      {this.status,
      this.code,
      this.message,
      this.totalOrders,
      this.totalClient});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    totalOrders = json['total_orders'];
    totalClient = json['total_client'];
  }
}

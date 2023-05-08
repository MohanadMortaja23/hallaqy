class AcceptedOrRejectedModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  AcceptedOrRejectedModel({this.status, this.code, this.message, this.data});

  AcceptedOrRejectedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? number;
  String? date;
  String? time;
  String? status;
  String? userName;
  String? userImage;
  String? userMobile;
  String? partnerName;
  String? partnerImage;
  String? employeeName;

  Data(
      {this.id,
      this.number,
      this.date,
      this.time,
      this.status,
      this.userName,
      this.userImage,
      this.userMobile,
      this.partnerName,
      this.partnerImage,
      this.employeeName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    userName = json['user_name'];
    userImage = json['user_image'];
    userMobile = json['user_mobile'];
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    employeeName = json['employee_name'];
  }
}

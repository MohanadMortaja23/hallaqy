class BookingModel {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  BookingModel({this.status, this.code, this.message, this.data});

  BookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
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
  String? partnerName;
  String? partnerImage;
  String? userMobile;
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
    partnerName = json['partner_name'];
    partnerImage = json['partner_image'];
    userMobile = json['user_mobile'];
    employeeName = json['employee_name'];
  }
}

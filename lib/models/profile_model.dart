class ProfileModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  ProfileModel({this.status, this.code, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic id;
  dynamic name;
  dynamic image;
  dynamic phone;
  dynamic lat;
  dynamic lng;
  dynamic address;
  dynamic token;
  dynamic status;
  dynamic limitTime;

  dynamic autoAccept;
  dynamic breakTimeFrom;
  dynamic breakTimeTo;
  dynamic countryId;
  dynamic hasEmployee;
  dynamic holidayId;

  Data(
      {this.id,
      this.name,
      this.image,
      this.phone,
      this.lat,
      this.lng,
      this.address,
      this.token,
      this.status,
      this.autoAccept,
      this.breakTimeFrom,
      this.breakTimeTo,
      this.countryId,
      this.limitTime,
      this.holidayId,
      this.hasEmployee});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
    token = json['token'];
    status = json['status'];
    autoAccept = json['auto_accept'];
    breakTimeFrom = json['break_time_from'];
    limitTime = json['limit_time'];
    holidayId = json['holiday_id'];

    breakTimeTo = json['break_time_to'];
    countryId = json['country_id'];
    hasEmployee = json['has_employee'];
  }
}

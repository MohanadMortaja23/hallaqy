class WorkTime {
  bool? status;
  int? code;
  String? message;
  List<Data>? data;

  WorkTime({this.status, this.code, this.message, this.data});

  WorkTime.fromJson(Map<String, dynamic> json) {
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
  String? day;
  String? from;
  String? to;
  bool? status;

  Data({this.id, this.day, this.from, this.to, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
  }
}

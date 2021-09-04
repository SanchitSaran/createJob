// To parse this JSON data, do
//
//     final myJobAppliedPojo = myJobAppliedPojoFromJson(jsonString);

import 'dart:convert';

MyJobAppliedPojo myJobAppliedPojoFromJson(String str) => MyJobAppliedPojo.fromJson(json.decode(str));

String myJobAppliedPojoToJson(MyJobAppliedPojo data) => json.encode(data.toJson());

class MyJobAppliedPojo {
  MyJobAppliedPojo({
    this.data,
    this.code,
    this.success,
  });

  List<Datum>? data;
  int? code;
  bool? success;

  factory MyJobAppliedPojo.fromJson(Map<String, dynamic> json) => MyJobAppliedPojo(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code == null ? null : code,
    "success": success == null ? null : success,
  };
}

class Datum {
  Datum({
    this.email,
    this.name,
    this.skills,
    this.id,
  });

  String? email;
  String? name;
  String? skills;
  String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    email: json["email"] == null ? null : json["email"],
    name: json["name"] == null ? null : json["name"],
    skills: json["skills"] == null ? null : json["skills"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "name": name == null ? null : name,
    "skills": skills == null ? null : skills,
    "id": id == null ? null : id,
  };
}

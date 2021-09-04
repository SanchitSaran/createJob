// To parse this JSON data, do
//
//     final registerPojo = registerPojoFromJson(jsonString);

import 'dart:convert';

RegisterPojo registerPojoFromJson(String str) => RegisterPojo.fromJson(json.decode(str));

String registerPojoToJson(RegisterPojo data) => json.encode(data.toJson());

class RegisterPojo {
  RegisterPojo({
    this.data,
    this.code,
    this.success,
  });

  Data? data;
  int? code;
  bool? success;

  factory RegisterPojo.fromJson(Map<String, dynamic> json) => RegisterPojo(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : data!.toJson(),
    "code": code == null ? null : code,
    "success": success == null ? null : success,
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.userRole,
    this.name,
    this.skills,
    this.updatedAt,
    this.createdAt,
    this.token,
  });

  String? id;
  String? email;
  int? userRole;
  String? name;
  String? skills;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    email: json["email"] == null ? null : json["email"],
    userRole: json["userRole"] == null ? null : json["userRole"],
    name: json["name"] == null ? null : json["name"],
    skills: json["skills"] == null ? null : json["skills"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    token: json["token"] == null ? null : json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "email": email == null ? null : email,
    "userRole": userRole == null ? null : userRole,
    "name": name == null ? null : name,
    "skills": skills == null ? null : skills,
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "token": token == null ? null : token,
  };
}

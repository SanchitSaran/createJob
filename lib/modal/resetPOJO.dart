// To parse this JSON data, do
//
//     final resetPojo = resetPojoFromJson(jsonString);

import 'dart:convert';

ResetPojo resetPojoFromJson(String str) => ResetPojo.fromJson(json.decode(str));

String resetPojoToJson(ResetPojo data) => json.encode(data.toJson());

class ResetPojo {
  ResetPojo({
    this.data,
    this.code,
    this.success,
  });

  Data? data;
  int? code;
  bool? success;

  factory ResetPojo.fromJson(Map<String, dynamic> json) => ResetPojo(
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
    this.token,
    this.email,
    this.valid,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  String? token;
  String? email;
  bool? valid;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    token: json["token"] == null ? null : json["token"],
    email: json["email"] == null ? null : json["email"],
    valid: json["valid"] == null ? null : json["valid"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "token": token == null ? null : token,
    "email": email == null ? null : email,
    "valid": valid == null ? null : valid,
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

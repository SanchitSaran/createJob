// To parse this JSON data, do
//
//     final applyJobPojo = applyJobPojoFromJson(jsonString);

import 'dart:convert';

ApplyJobPojo applyJobPojoFromJson(String str) => ApplyJobPojo.fromJson(json.decode(str));

String applyJobPojoToJson(ApplyJobPojo data) => json.encode(data.toJson());

class ApplyJobPojo {
  ApplyJobPojo({
    this.data,
    this.code,
    this.success,
  });

  Data? data;
  int? code;
  bool? success;

  factory ApplyJobPojo.fromJson(Map<String, dynamic> json) => ApplyJobPojo(
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
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

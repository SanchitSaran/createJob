// To parse this JSON data, do
//
//     final appliedJobPojo = appliedJobPojoFromJson(jsonString);

import 'dart:convert';

AppliedJobPojo appliedJobPojoFromJson(String str) => AppliedJobPojo.fromJson(json.decode(str));

String appliedJobPojoToJson(AppliedJobPojo data) => json.encode(data.toJson());

class AppliedJobPojo {
  AppliedJobPojo({
    this.data,
    this.code,
    this.success,
  });

  List<Datum>? data;
  int? code;
  bool? success;

  factory AppliedJobPojo.fromJson(Map<String, dynamic> json) => AppliedJobPojo(
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
    this.title,
    this.description,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  String? title;
  String? description;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    location: json["location"] == null ? null : json["location"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "location": location == null ? null : location,
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "id": id == null ? null : id,
  };
}

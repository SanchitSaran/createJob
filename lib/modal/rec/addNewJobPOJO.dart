// To parse this JSON data, do
//
//     final addJobsPojo = addJobsPojoFromJson(jsonString);

import 'dart:convert';

AddJobsPojo addJobsPojoFromJson(String str) => AddJobsPojo.fromJson(json.decode(str));

String addJobsPojoToJson(AddJobsPojo data) => json.encode(data.toJson());

class AddJobsPojo {
  AddJobsPojo({
    this.data,
    this.code,
    this.success,
  });

  Data? data;
  int? code;
  bool? success;

  factory AddJobsPojo.fromJson(Map<String, dynamic> json) => AddJobsPojo(
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
    this.title,
    this.description,
    this.location,
    this.updatedAt,
    this.createdAt,
  });

  String? id;
  String? title;
  String? description;
  String? location;
  DateTime? updatedAt;
  DateTime? createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    location: json["location"] == null ? null : json["location"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "location": location == null ? null : location,
    "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final jobsPojo = jobsPojoFromJson(jsonString);

import 'dart:convert';

JobsPojo jobsPojoFromJson(String str) => JobsPojo.fromJson(json.decode(str));

String jobsPojoToJson(JobsPojo data) => json.encode(data.toJson());

class JobsPojo {
  JobsPojo({
    this.data,
    this.code,
    this.success,
    this.metadata,
  });

  List<Datum>? data;
  int? code;
  bool? success;
  Metadata? metadata;

  factory JobsPojo.fromJson(Map<String, dynamic> json) => JobsPojo(
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    code: json["code"] == null ? null : json["code"],
    success: json["success"] == null ? null : json["success"],
    metadata: json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code == null ? null : code,
    "success": success == null ? null : success,
    "metadata": metadata == null ? null : metadata!.toJson(),
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

class Metadata {
  Metadata({
    this.count,
    this.limit,
  });

  int? count;
  int? limit;

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    count: json["count"] == null ? null : json["count"],
    limit: json["limit"] == null ? null : json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "limit": limit == null ? null : limit,
  };
}

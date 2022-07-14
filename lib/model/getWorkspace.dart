// To parse this JSON data, do
//
//     final getWorkspace = getWorkspaceFromJson(jsonString);

import 'dart:convert';

GetWorkspace getWorkspaceFromJson(String str) => GetWorkspace.fromJson(json.decode(str));

String getWorkspaceToJson(GetWorkspace data) => json.encode(data.toJson());

class GetWorkspace {
  GetWorkspace({
    required this.id,
    required this.uuid,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.description,
  });

  int id;
  String uuid;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String description;

  factory GetWorkspace.fromJson(Map<String, dynamic> json) => GetWorkspace(
    id: json["id"],
    uuid: json["uuid"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "name": name,
    "description": description,
  };
}

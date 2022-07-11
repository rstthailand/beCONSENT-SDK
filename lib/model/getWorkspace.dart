import 'dart:convert';

GetWorkspace getWorkspaceFromJson(String str) => GetWorkspace.fromJson(json.decode(str));

String getWorkspaceToJson(GetWorkspace data) => json.encode(data.toJson());

class GetWorkspace {
    GetWorkspace({
        this.id,
        this.uuid,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.description,
    });

    int? id;
    String? uuid;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? name;
    String? description;

    factory GetWorkspace.fromJson(Map<String, dynamic> json) => GetWorkspace(
        id: json["id"] == null ? null : json["id"],
        uuid: json["uuid"] == null ? null : json["uuid"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uuid": uuid == null ? null : uuid,
        "createdAt": createdAt == null ? null : createdAt?.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "name": name == null ? null : name,
        "description": description == null ? null : description,
    };
}
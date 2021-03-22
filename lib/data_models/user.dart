// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.accessToken,
    this.user,
  });

  String accessToken;
  UserDatum user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        accessToken: json["accessToken"],
        user: UserDatum.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user.toJson(),
      };
}

class UserDatum {
  UserDatum(
      {this.id,
      this.status,
      this.email,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.name});

  String id;
  int status;
  String email;
  int role;
  DateTime createdAt;
  DateTime updatedAt;
  String phone;
  String name;
  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
      id: json["_id"],
      status: json["status"] ?? 0,
      email: json["email"] ?? '',
      role: json["role"] ?? 0,
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]).toLocal() : null,
      updatedAt:
          json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]).toLocal() : null,
      phone: json["phone"] ?? '',
      name: json["name"] ?? '');

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "email": email,
        "role": role,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "phone": phone,
        'name': name
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDatum && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

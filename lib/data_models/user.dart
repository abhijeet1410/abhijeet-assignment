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

  String? accessToken;
  User? user;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        accessToken: json["accessToken"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "user": user?.toJson(),
      };
}

class User {
  User(
      {required this.id,
      this.name,
      this.phone,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.newUserLogin,
      this.email,
      this.avatar});

  String id;
  String? name;
  String? phone;
  int? role;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? newUserLogin;
  String? email;
  String? avatar;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
        role: json["role"] ?? 1,
        status: json["status"] ?? 1,
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
        newUserLogin: json["newUserLogin"] ?? false,
        email: json["email"] ?? '',
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "role": role,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "newUserLogin": newUserLogin,
        "email": email,
        'avatar': avatar
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

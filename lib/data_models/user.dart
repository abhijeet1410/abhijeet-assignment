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
      this.firstName,
      this.lastName,
      this.avatar,
      this.phone,
      this.password,
      this.role,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.newUserLogin,
      this.address,
      this.dob,
      this.email});

  String id;
  String? firstName;
  String? lastName;
  String? phone;
  String? avatar;
  String? password;
  int? role;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? newUserLogin;
  String? email;
  Address? address;
  DateTime? dob;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
        phone: json["phone"] ?? '',
        password: json["password"] ?? '',
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
        address:
            json["address"] != null && json["address"] is Map<String, dynamic>
                ? Address.fromJson(json["address"])
                : null,
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "dob": dob != null ? dob!.toIso8601String() : null,
        "password": password,
        "role": role,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "newUserLogin": newUserLogin,
        "email": email,
        'avatar': avatar,
        "address": address,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Address {
  Address({
    this.addressLine1,
    this.addressLine2,
    this.street,
    this.city,
    this.pinCode,
  });

  String? addressLine1;
  String? addressLine2;
  String? street;
  String? city;
  String? pinCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        street: json["street"],
        city: json["city"],
        pinCode: json["pinCode"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "street": street,
        "city": city,
        "pinCode": pinCode,
      };
}

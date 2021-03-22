///
/// Created by Sunil Kumar from Boiler plate
///
class SocialSignInResponse {
  SocialSignInResponse({this.name, this.avatar, this.email});

  String? name;
  String? email;
  String? avatar;

  factory SocialSignInResponse.fromJson(Map<String, dynamic> json) =>
      SocialSignInResponse(
        name: json["user"]['name'],
        email: json["user"]['email'],
        avatar: json["user"]['avatar'],
      );

  Map<String, dynamic> toJson() => {
        "user": {"name": name, "email": email, "avatar": avatar},
      };
}

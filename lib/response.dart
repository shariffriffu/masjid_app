import 'dart:convert';

Epos eposFromJson(String str) => Epos.fromJsonString(str);

String eposToJson(Epos data) => json.encode(data.toJson());

class Epos {
  String loginScreen;

  Epos({
    required this.loginScreen,
  });

  factory Epos.fromJson(Map<String, dynamic> json) => Epos(
        loginScreen: json["login_screen"] ?? "",
      );

  static Epos fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Epos.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => {
        "login_screen": loginScreen,
      };
}

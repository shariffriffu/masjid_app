import 'dart:convert';

Epos eposFromJson(String str) => Epos.fromJsonString(str);

String eposToJson(Epos data) => json.encode(data.toJson());

class Epos {
  String login_screen;
 

  Epos({
    required this.login_screen,
   

    
  });

  factory Epos.fromJson(Map<String, dynamic> json) => Epos(
        login_screen: json["login_screen"] ?? "",
       
      );

  static Epos fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return Epos.fromJson(jsonMap);
  }

  Map<String, dynamic> toJson() => {
        "login_screen": login_screen,
             };
}

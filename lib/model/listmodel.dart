import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.success,
    this.symbols,
  });

  bool? success;
  Map<String, String>? symbols;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        success: json["success"],
        symbols: Map.from(json["symbols"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "symbols":
            Map.from(symbols!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

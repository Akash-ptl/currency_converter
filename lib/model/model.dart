import 'dart:convert';

Datalist datalistFromJson(String str) => Datalist.fromJson(json.decode(str));

String datalistToJson(Datalist data) => json.encode(data.toJson());

class Datalist {
  Datalist({
    this.success,
    this.timestamp,
    this.base,
    this.date,
    this.rates,
  });

  bool? success;
  int? timestamp;
  String? base;
  DateTime? date;
  Map<String, double>? rates;

  factory Datalist.fromJson(Map<String, dynamic> json) => Datalist(
        success: json["success"],
        timestamp: json["timestamp"],
        base: json["base"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        rates: Map.from(json["rates"])
            .map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "timestamp": timestamp,
        "base": base,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "rates":
            Map.from(rates!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

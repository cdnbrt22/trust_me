// To parse this JSON data, do
//
//     final covidToWorlds = covidToWorldsFromJson(jsonString);

import 'dart:convert';

Map<String, CovidToWorlds> covidToWorldsFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, CovidToWorlds>(k, CovidToWorlds.fromJson(v)));

String covidToWorldsToJson(Map<String, CovidToWorlds> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CovidToWorlds {
  CovidToWorlds({
    this.name,
    this.description,
    this.path,
  });

  String name;
  String description;
  String path;

  factory CovidToWorlds.fromJson(Map<String, dynamic> json) => CovidToWorlds(
        name: json["Name"] == null ? null : json["Name"],
        description: json["Description"] == null ? null : json["Description"],
        path: json["Path"] == null ? null : json["Path"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? null : name,
        "Description": description == null ? null : description,
        "Path": path == null ? null : path,
      };
}

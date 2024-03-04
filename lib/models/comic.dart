
import 'dart:convert';
import 'detail.dart';


class Comic {
  String apiDetailUrl;
  DateTime coverDate;
  int id;
  String image;
  String issueNumber;
  String? name;
  String? description;
  List<Detail> characterCredits;
  List<Detail> teamCredits;
  List<Detail> locationCredits;

  Comic({
    required this.apiDetailUrl,
    required this.coverDate,
    required this.id,
    required this.image,
    required this.issueNumber,
    required this.name,
    required this.description,
    required this.characterCredits,
    required this.teamCredits,
    required this.locationCredits,
  });

  factory Comic.fromJson(String str) => Comic.fromMap(json.decode(str));

  factory Comic.fromMap(Map<String, dynamic> json) => Comic(
    apiDetailUrl: json["api_detail_url"],
    coverDate: DateTime.parse(json["cover_date"]),
    id: json["id"],
    image: json["image"]["small_url"] ?? "https://via.placeholder.com/100x100",
    issueNumber: json["issue_number"] ?? "NA",
    name: json["name"] ?? "Untitled Comic",
    description: json["description"] ?? "NA",
    characterCredits: (json["character_credits"] as List?)?.map((x) => Detail.fromMap(x)).toList() ?? [],
    teamCredits: (json["team_credits"] as List?)?.map((x) => Detail.fromMap(x)).toList() ?? [],
    locationCredits: (json["location_credits"] as List?)?.map((x) => Detail.fromMap(x)).toList() ?? [],
  );

  static Comic empty() {
    return Comic(
      apiDetailUrl: "",
      coverDate: DateTime.now(), // Set to current date for empty object
      id: 0,
      image: "",
      issueNumber: "",
      name: "",
      description: "",
      characterCredits: [],
      teamCredits: [],
      locationCredits: [],
    );
  }
}
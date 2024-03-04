
import 'dart:convert';

class Detail {
  String apiDetailUrl;
  int id;
  String name;
  String? image;

  Detail({
    required this.apiDetailUrl,
    required this.id,
    required this.name,
    this.image,
  });

  factory Detail.fromJson(String str) => Detail.fromMap(json.decode(str));

  factory Detail.fromMap(Map<String, dynamic> json) => Detail(
    apiDetailUrl: json["api_detail_url"],
    id: json["id"],
    name: json["name"] ?? "Untitled Comic",
    image: "https://via.placeholder.com/100x100", // Se asigna una imagen por defecto
  );
}
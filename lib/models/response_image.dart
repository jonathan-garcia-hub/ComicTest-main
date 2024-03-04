import 'dart:convert';

import 'models.dart';

class ResponseImage {
  String error;
  int statusCode;
  String image;

  ResponseImage({
    required this.error,
    required this.statusCode,
    required this.image,
  });

  factory ResponseImage.fromJson(String str) => ResponseImage.fromMap(json.decode(str));

  factory ResponseImage.fromMap(Map<String, dynamic> json) => ResponseImage(
    error: json["error"],
    statusCode: json["status_code"],
    image: json["results"]["image"]["small_url"],
  );

}

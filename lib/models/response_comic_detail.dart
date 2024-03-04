import 'dart:convert';

import 'package:comics/models/comic.dart';

class ResponseComicDetails {
  String error;
  int statusCode;
  Comic comic;

  ResponseComicDetails({
    required this.error,
    required this.statusCode,
    required this.comic,
  });

  factory ResponseComicDetails.fromJson(String str) => ResponseComicDetails.fromMap(json.decode(str));

  factory ResponseComicDetails.fromMap(Map<String, dynamic> json) => ResponseComicDetails(
    error: json["error"],
    statusCode: json["status_code"],
    comic: Comic.fromMap(json["results"]),
  );

}

import 'dart:convert';

import 'comic.dart';

class ResponseListComic {
  String error;
  int statusCode;
  List<Comic> comics;

  ResponseListComic({
    required this.error,
    required this.statusCode,
    required this.comics,
  });

  factory ResponseListComic.fromJson(String str) => ResponseListComic.fromMap(json.decode(str));

  factory ResponseListComic.fromMap(Map<String, dynamic> json) => ResponseListComic(
    error: json["error"],
    statusCode: json["status_code"],
    comics: List<Comic>.from(json["results"].map((x) => Comic.fromMap(x))),
  );

}








import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:comics/models/models.dart';

import '../models/response_comic_detail.dart';
import '../models/response_comic_list.dart';
import '../models/response_image.dart';

class ComicProvider extends ChangeNotifier {

  String _apiKey = "82afc8ea6d31b5301eefc429ed738e806bbe9525";
  String _baseUrl = 'comicvine.gamespot.com';

  List<Comic> comicsList = [];

  ComicProvider() {
    getComicList();
  }

  Future<String> _getJsonData(String endpoint) async {


    final url = Uri.https(_baseUrl, endpoint, {
      'api_key': '$_apiKey',
      'format': 'json'
    });

    final response = await http.get(url);
    return response.body;
  }

  //Para obtener listado de comics
  getComicList() async {
    try {
      final jsonData = await _getJsonData('/api/issues');
      final listComicResponse = ResponseListComic.fromJson(jsonData);

      comicsList = listComicResponse.comics;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  //Para obtener el detalle de un comic
  Future<Comic> getComicDetail(int comicId) async {

    try {
      final jsonData = await _getJsonData('/api/issue/4000-$comicId');
      final comicDetail = ResponseComicDetails.fromJson(jsonData);

      if (comicDetail.comic.characterCredits.isNotEmpty){
        // Descarga imágenes para créditos de personajes.
        final futures = comicDetail.comic.characterCredits.map((element) async {
          final imageUrlData = await _getJsonData('/api/character/4005-${element.id}');
          final imageData = ResponseImage.fromJson(imageUrlData);

          return imageData.image;
        });

        // Espera  a que se descarguen todas las imágenes.
        final downloadedImages = await Future.wait(futures);

        // Asigna imágenes descargadas a créditos de personajes.
        for (int i = 0; i < comicDetail.comic.characterCredits.length; i++) {
          comicDetail.comic.characterCredits[i].image = downloadedImages[i];
        }
      }

      if (comicDetail.comic.teamCredits.isNotEmpty){
        // Descarga imágenes para créditos de equipos.
        final futures = comicDetail.comic.teamCredits.map((element) async {
          final imageUrlData = await _getJsonData('/api/team/4060-${element.id}');
          final imageData = ResponseImage.fromJson(imageUrlData);
          return imageData.image;
        });

        // Espera  a que se descarguen todas las imágenes.
        final downloadedImages = await Future.wait(futures);

        // Asigna imágenes descargadas a créditos de equipos.
        for (int i = 0; i < comicDetail.comic.teamCredits.length; i++) {
          comicDetail.comic.teamCredits[i].image = downloadedImages[i];
        }
      }

      if (comicDetail.comic.locationCredits.isNotEmpty){
        // Download images for character credits concurrently
        final futures = comicDetail.comic.locationCredits.map((element) async {
          final imageUrlData = await _getJsonData('/api/location/4020-${element.id}');
          final imageData = ResponseImage.fromJson(imageUrlData);
          return imageData.image; // Return the downloaded image object
        });

        // Wait for all images to be downloaded
        final downloadedImages = await Future.wait(futures);

        // Asigna imágenes descargadas a créditos de locación.
        for (int i = 0; i < comicDetail.comic.locationCredits.length; i++) {
          comicDetail.comic.locationCredits[i].image = downloadedImages[i];
        }
      }

      return comicDetail.comic;
    } catch (error) {
      print(error);
      return Comic.empty();
    }
  }

}

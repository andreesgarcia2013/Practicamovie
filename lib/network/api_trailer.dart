import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practica2/models/trailer_model.dart';

class ApiTrailer {
  Future<List<TrailerModel>?> getAllTrailer(String id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/videos?api_key=6a5fb47076ad7d8661b04d9c1ebf2e7f');
    print(id);
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var video = jsonDecode(response.body)['results'] as List;
      return video.map((movie) => TrailerModel.fromMap(movie)).toList();
    } else {
      return null;
    }
  }
}
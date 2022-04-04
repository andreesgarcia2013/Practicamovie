import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:practica2/models/actors_model.dart';

class ApiActors{
  Future<List<ActorsModel>?> getAllActors(String id) async {
    var URL = Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=dfe9fbe4707e2ddcc71f5c2cb738d616&language=en-US');
    print(id);
    var response = await http.get(URL);
    if (response.statusCode == 200) {
      var actor = jsonDecode(response.body)['cast'] as List;
      return actor.map((movie) => ActorsModel.fromMap(movie)).toList();
    } else {
      return null;
    }
  }
}
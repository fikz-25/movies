import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/model/film_models.dart';

class FilmRepository {
  Future<List<Film>> getFilm() async {
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=2a83f010bf5301cc6bb32a0ae9437b91&language=en-US&page=1");
    var response = await http.get(url);

    var jsonObject = json.decode(response.body);
    List<dynamic> listFilm = (jsonObject as Map<String, dynamic>)['results'];

    List<Film> films = [];
    for (int i = 0; i < listFilm.length; i++) {
      films.add(Film.fromJSON(listFilm[i]));
    }

    print(films);

    return films;
  }
}

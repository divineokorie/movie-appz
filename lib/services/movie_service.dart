import 'package:dio/dio.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/services/http_service.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HTTPService _http;

  MovieService() {
    _http = getIt.get<HTTPService>();
  }

  Future<List<Movie>> getPopularMovies({int? page}) async {
    Response response = await _http.get('/movie/popular', query: {
      "page": page,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      //data is a map, then the key results is called, then its being cast to a map named movieData
      List<Movie> movies = data["results"].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load popular movies.");
    }
  }

  Future<List<Movie>> getUpcomingMovies({int? page}) async {
    Response response = await _http.get('/movie/upcoming', query: {
      "page": page,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data["results"].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load upcoming movies.");
    }
  }

  Future<List<Movie>> searchMovies(
      {required String searchTerm, int? page}) async {
    Response response = await _http.get('/search/movie', query: {
      "query": searchTerm,
      "page": page,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data["results"].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't movies search.");
    }
  }
}

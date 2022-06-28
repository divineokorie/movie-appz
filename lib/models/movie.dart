import 'package:flickd_app/models/app_config.dart';
import 'package:get_it/get_it.dart';

class Movie {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backdropPath;
  final num rating;
  final String releaseDate;

  Movie(
      {required this.name,
      required this.language,
      required this.isAdult,
      required this.description,
      required this.posterPath,
      required this.backdropPath,
      required this.rating,
      required this.releaseDate});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name: json["title"],
      language: json["original_language"],
      isAdult: json["adult"],
      description: json["overview"],
      posterPath: json["poster_path"],
      backdropPath: json["backdrop_path"] ?? '',
      rating: json["vote_average"],
      releaseDate: json["release_date"] ?? '',
    );
  }

  String posterUrl() {
    final AppConfig appConfig = GetIt.instance.get<AppConfig>();
    return '${appConfig.BASE_IMAGE_API_URL}$posterPath';
  }
}

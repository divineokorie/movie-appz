import 'package:flickd_app/models/main_page_data.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/models/search_category.dart';
import 'package:flickd_app/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  //call initial, thats what super is for, set the class to this default
  MainPageDataController() : super(MainPageData.initial()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<Movie> movies = [];
      if (state.searchText!.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          movies = await _movieService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          movies = await _movieService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          movies = [];
        }
      } else {
        movies =
            await _movieService.searchMovies(searchTerm: state.searchText!);
      }
      //change state when gotten
      state = state.copyWith(
          //add the movies to state.movies which is a empty list at first, and if not empty adds the new list to it
          movies: [...state.movies!, ...movies],
          searchCategory: state.searchCategory!,
          page: state.page! + 1,
          searchText: state.searchText!);
    } catch (e) {
      rethrow;
    }
  }

  void updateSearchCategory({String? category}) async {
    if (category != null) {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: '');
      getMovies();
    }
  }

  void updateTextSearch(String searchText) async {
    state = state.copyWith(
        movies: [],
        page: 1,
        searchCategory: SearchCategory.none,
        searchText: searchText);
    getMovies();
  }
}

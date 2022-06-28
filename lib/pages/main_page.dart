import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flickd_app/controllers/main_page_data_controller.dart';
import 'package:flickd_app/models/main_page_data.dart';
import 'package:flickd_app/models/search_category.dart';
import 'package:flickd_app/widgets/movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
  return MainPageDataController();
});

var selectedMoviePosterUrlProvider = StateProvider<String?>((ref) {
  final movies = ref.watch(mainPageDataControllerProvider).movies;
  return movies!.isNotEmpty ? movies[0].posterUrl() : null;
});

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  final TextEditingController _searchTextFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    final mainPageData = ref.watch(mainPageDataControllerProvider);
    final selectedMoviePosterUrl = ref.watch(selectedMoviePosterUrlProvider);

    _searchTextFieldController.text = mainPageData.searchText!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _backgroundWidget(selectedMoviePosterUrl),
            _foregroundWidget(mainPageData, selectedMoviePosterUrl),
          ],
        ),
      ),
    );
  }

  Widget _foregroundWidget(MainPageData mainPageData, selectedMoviePosterUrl) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _topBarWidget(mainPageData),
          _movieListViewWidget(mainPageData, selectedMoviePosterUrl),
        ],
      ),
    );
  }

  Widget _topBarWidget(MainPageData mainPageData) {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: _deviceWidth * 0.5,
            height: _deviceHeight * 0.05,
            child: TextField(
                controller: _searchTextFieldController,
                onSubmitted: (input) => input.isNotEmpty
                    ? ref
                        .read(mainPageDataControllerProvider.notifier)
                        .updateTextSearch(input)
                    : null,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white24,
                    ),
                    hintStyle: TextStyle(color: Colors.white54),
                    filled: false,
                    fillColor: Colors.white24,
                    hintText: "Search...")),
          ),
          DropdownButton(
            dropdownColor: Colors.black38,
            value: mainPageData.searchCategory,
            icon: const Icon(
              Icons.menu,
              color: Colors.white24,
            ),
            underline: Container(
              height: 1,
              color: Colors.white24,
            ),
            onChanged: (value) {
              value.toString().isNotEmpty
                  ? ref
                      .read(mainPageDataControllerProvider.notifier)
                      .updateSearchCategory(category: value.toString())
                  : null;
            },
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem(
                value: SearchCategory.popular,
                child: Text(
                  SearchCategory.popular,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: SearchCategory.upcoming,
                child: Text(
                  SearchCategory.upcoming,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              DropdownMenuItem(
                value: SearchCategory.none,
                child: Text(
                  SearchCategory.none,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _movieListViewWidget(
      MainPageData mainPageData, selectedMoviePosterUrl) {
    return Container(
      height: _deviceHeight * 0.83,
      padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
      child: mainPageData.movies != null
          ? NotificationListener(
              onNotification: (onScrollNotification) {
                if (onScrollNotification is ScrollEndNotification) {
                  final before = onScrollNotification.metrics.extentBefore;
                  final max = onScrollNotification.metrics.maxScrollExtent;
                  if (before == max) {
                    ref
                        .read(mainPageDataControllerProvider.notifier)
                        .getMovies();
                    return true;
                  }
                  return false;
                }
                return false;
              },
              child: ListView.builder(
                  itemCount: mainPageData.movies!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = mainPageData.movies![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: _deviceHeight * 0.01, horizontal: 0),
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedMoviePosterUrlProvider.notifier)
                              .state = movie.posterUrl();
                        },
                        child: MovieTile(
                            height: _deviceHeight * 0.2,
                            width: _deviceWidth * 0.85,
                            movie: movie),
                      ),
                    );
                  }),
            )
          : const Center(
              child: CircularProgressIndicator(backgroundColor: Colors.white),
            ),
    );
  }

  Widget _backgroundWidget(String? selectedMoviePosterUrl) {
    if (selectedMoviePosterUrl != null) {
      return Container(
        height: _deviceHeight,
        width: _deviceWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  selectedMoviePosterUrl,
                ),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      );
    } else {
      return Container(
        height: _deviceHeight,
        width: _deviceWidth,
        color: Colors.black,
      );
    }
  }
}

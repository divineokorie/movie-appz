import 'package:flickd_app/models/movie.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatelessWidget {
  final double height;
  final double width;
  final Movie movie;

  const MovieTile(
      {Key? key,
      required this.height,
      required this.width,
      required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _moviePosterWidget(movie.posterUrl()),
          _movieInfoWidget(),
        ]);
  }

  Widget _moviePosterWidget(String imageUrl) {
    return Container(
      height: height,
      width: width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(imageUrl)),
      ),
    );
  }

  Widget _movieInfoWidget() {
    return SizedBox(
      height: height,
      width: width * 0.66,
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: width * 0.56,
                    child: Text(
                      movie.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  Text(
                    movie.rating.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
                child: Text(
                  "${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, height * 0.07, 0, 0),
                child: Text(movie.description,
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 10)),
              )
            ]),
      ),
    );
  }
}

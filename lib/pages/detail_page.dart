import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../widgets/background_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(
      {Key? key,
      required this.image,
      required this.deviceWidth,
      required this.deviceHeight,
      required this.movie})
      : super(key: key);
  final String image;
  final double deviceWidth, deviceHeight;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          backgroundWidget(image, deviceWidth, deviceHeight),
          detailForegroundWidget(),
        ],
      ),
    );
  }

  detailForegroundWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: deviceHeight / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: (NetworkImage(movie.posterUrl())),
                    fit: BoxFit.cover)),
          ),
          moreInfoWidget()
        ],
      ),
    );
  }

  moreInfoWidget() {
    return SizedBox(
      width: deviceWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    movie.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Text(
                  movie.rating.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, deviceHeight * 0.02, 15, 0),
            child: Text(
              "${movie.language.toUpperCase()} | R: ${movie.isAdult} | ${movie.releaseDate}",
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(15, deviceHeight * 0.03, 15, 0),
            child: Text(movie.description,
                style: const TextStyle(color: Colors.white70, fontSize: 20)),
          )
        ],
      ),
    );
  }
}

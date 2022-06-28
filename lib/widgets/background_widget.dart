import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget backgroundWidget(
    String? selectedMoviePosterUrl, double deviceWidth, double deviceHeight) {
  if (selectedMoviePosterUrl != null) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
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
      height: deviceHeight,
      width: deviceWidth,
      color: Colors.black,
    );
  }
}

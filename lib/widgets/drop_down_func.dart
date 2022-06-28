import 'package:flutter/material.dart';
import '../models/search_category.dart';

List<DropdownMenuItem<String>> getDropDownMenu() => [
      const DropdownMenuItem(
        value: SearchCategory.popular,
        child: Text(
          SearchCategory.popular,
          style: TextStyle(color: Colors.white),
        ),
      ),
      const DropdownMenuItem(
        value: SearchCategory.upcoming,
        child: Text(
          SearchCategory.upcoming,
          style: TextStyle(color: Colors.white),
        ),
      ),
      const DropdownMenuItem(
        value: SearchCategory.none,
        child: Text(
          SearchCategory.none,
          style: TextStyle(color: Colors.white),
        ),
      ),
      // const DropdownMenuItem(
      //   value: SearchCategory.upcoming,
      //   child: Text(
      //     SearchCategory.upcoming,
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      // const DropdownMenuItem(
      //   value: SearchCategory.upcoming,
      //   child: Text(
      //     SearchCategory.upcoming,
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
    ];

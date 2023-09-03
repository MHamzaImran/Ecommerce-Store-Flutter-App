import 'package:flutter/material.dart';
import 'package:mab_lab8/store/store_screen.dart';

void main() {
  runApp(
    const AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Store',
        home: MyStorePage(),
      ),
    ),
  );
}

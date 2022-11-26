import 'package:flutter/material.dart';
import 'screens/detail_page.dart';
import 'screens/homepage.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
        'detail_page': (context) => const DetailPage(),
      },
    ),
  );
}

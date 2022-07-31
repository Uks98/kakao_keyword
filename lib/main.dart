import 'package:flutter/material.dart';
import 'package:keyword_map/page/maplist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'keyword_map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapListPage(),
    );
  }
}

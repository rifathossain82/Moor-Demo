import 'package:flutter/material.dart';
import 'package:moor_database_demo/pages/homepage.dart';
import 'package:provider/provider.dart';

import 'data/moor_database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      // The single instance of AppDatabase
      builder: (_) => AppDatabase(),
      create: (BuildContext context) {  },
      child: MaterialApp(
        title: 'Material App',
        home: Homepage(),
      ),
    );
  }
}
// lib/main.dart
import 'package:flutter/material.dart';
import 'views/contact_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Danh bạ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListScreen(),
      );
  }
}
import 'package:flutter/material.dart';
import 'package:netflix/core/services/services_locator.dart';
import 'package:netflix/movies/presentation/screens/movies_screen.dart';

void main() {
  ServicesLocator().init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade900 ),
      home: const MoviesScreen(),
    );
  }
}

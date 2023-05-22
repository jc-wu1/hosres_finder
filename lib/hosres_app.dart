import 'package:flutter/material.dart';
import 'package:hosres_finder/features/home/home_page.dart';

class HosResApp extends StatelessWidget {
  const HosResApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HosRes Finder App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

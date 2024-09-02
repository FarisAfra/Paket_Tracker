import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:paket_tracker_app/screens/homepage.dart';
import 'package:paket_tracker_app/screens/splashscreen.dart';

Future<void> main() async {
  // Memuat file .env
  await dotenv.load(); // Load the .env file
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paket Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}

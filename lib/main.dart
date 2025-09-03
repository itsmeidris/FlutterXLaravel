import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laravel_demo_app/views/screens/students_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      home: Scaffold(backgroundColor: Colors.white, body: StudentsScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}

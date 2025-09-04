import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laravel_demo_app/controllers/student_controller.dart';
import 'package:laravel_demo_app/routes/app_routes.dart';

void main() {
  Get.put(StudentController()); // inject once
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.appRouter,
      theme: ThemeData(textTheme: GoogleFonts.latoTextTheme()),
      debugShowCheckedModeBanner: false,
    );
  }
}

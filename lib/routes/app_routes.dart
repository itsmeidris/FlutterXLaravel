import 'package:go_router/go_router.dart';
import 'package:laravel_demo_app/views/screens/sign_in_screen.dart';
import 'package:laravel_demo_app/views/screens/sign_up_screen.dart';
import 'package:laravel_demo_app/views/screens/students_screen.dart';

class AppRoutes {
  static final appRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: "/",
        name: "signup",
        builder: (context, child) {
          return SignUpScreen();
        },
      ),
      GoRoute(
        path: "/signin",
        name: "signin",
        builder: (context, child) {
          return SignInScreen();
        },
      ),
      GoRoute(
        path: "/main",
        name: "main",
        builder: (context, child) {
          return StudentsScreen();
        },
      ),
    ],
  );
}

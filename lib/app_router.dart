import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/presention/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  MaterialPageRoute genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
    }
  }
}

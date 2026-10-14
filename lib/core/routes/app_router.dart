import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/features/auth/presentation/ui/login_screen.dart';
import 'package:bookia/features/welcome/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.LoginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.WelcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
    }
  }
}

import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:bookia/features/auth/presentation/ui/login_screen.dart';
import 'package:bookia/features/auth/presentation/ui/register_screen.dart';
import 'package:bookia/features/book_details/presentation/cubit/bookdetails_cubit.dart';
import 'package:bookia/features/book_details/presentation/ui/book_details_screen.dart';
import 'package:bookia/features/bottom_nav_bar/data/ui/bottom_nav_bar.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/ui/home_screen.dart';
import 'package:bookia/features/home/presentation/ui/search_screen.dart';
import 'package:bookia/features/welcome/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.NavBarScreen:
        return MaterialPageRoute(builder: (_) => NavBarScreen());
      case AppRoutes.LoginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginScreen(),
          ),
        );
      case AppRoutes.WelcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case AppRoutes.RegisterScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.HomeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..GetBestSellerBooks(),
            child: HomeScreen(),
          ),
        );
      case AppRoutes.SearchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..getSearch(""),
            child: SearchScreen(),
          ),
        );
      case AppRoutes.BookDetailsScreen:
        final id = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BookdetailsCubit()..getDetails(id),
            child: BookDetailsScreen(bookId: id),
          ),
        );
      default:
        return null;
    }
  }
}

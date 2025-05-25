import 'package:flutter/material.dart';
import 'package:testw/screens/challenge_screen.dart';
import 'package:testw/screens/dasboard_screen.dart';
//import 'package:testw/screens/contador_screen.dart';
import 'package:testw/screens/contador_screen.dart';
import 'package:testw/screens/detail_popular_movie.dart';
import 'package:testw/screens/login_screen.dart';
import 'package:testw/screens/pantallas_screen.dart';
import 'package:testw/screens/popular_screen.dart';
import 'package:testw/screens/favorites_screen.dart';
import 'package:testw/utils/global_values.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalValues.themeMode,
      
      builder: (context,value,widget) {
        return MaterialApp(
            theme: value == 1 ? ThemeData.light() : ThemeData.dark(),
            home: const LoginScreen(),
            routes: {
              "/dash" : (context) => const DashboardScreen(),
              "/counter" : (context) => const ContadorScreen(),
              "/reto" : (context) => const ChallengeScreen(),
              "/pantallas" : (context) => const PantallasMenu(),
              "/api" : (context) => const PopularScreen(),
              "/detail" : (context) => const DetailPopularMovie(),
              '/favorites': (context) => const FavoritesScreen(),
            },
        );
      }
    );
  }
}


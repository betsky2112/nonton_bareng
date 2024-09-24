import 'package:flutter/material.dart';
import 'package:nonton_bareng/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'providers/movie_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()..fetchPopularMovies()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()..loadFavorites()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        home: HomeScreen(),
      ),
    );
  }
}

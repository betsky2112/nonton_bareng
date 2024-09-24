import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie_model.dart';
import '../providers/favorite_provider.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        actions: [
          Consumer<FavoriteProvider>(
            builder: (context, favoriteProvider, child) {
              return FutureBuilder<bool>(
                future: favoriteProvider.isFavorite(movie.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();

                  final isFavorite = snapshot.data!;
                  return IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        favoriteProvider.removeFavorite(movie.id);
                      } else {
                        favoriteProvider.addFavorite(movie);
                      }
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tambahkan informasi film seperti gambar, sinopsis, dll.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              movie.overview,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

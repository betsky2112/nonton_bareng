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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan poster film
              Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                movie.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Release Date: ${movie.releaseDate}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Rating: ${movie.rating}/10',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Runtime: ${movie.runTime} minutes',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Overview',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                movie.overview,
                style: const TextStyle(fontSize: 16),
              ),
              // Tempat untuk menampilkan trailer jika tersedia
              const SizedBox(height: 16),
              // Jika Anda mendapatkan link trailer, tampilkan di sini
              // Contoh:
              // ElevatedButton(
              //   onPressed: () {
              //     // Navigasi ke trailer atau tampilkan modal
              //   },
              //   child: Text('Watch Trailer'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

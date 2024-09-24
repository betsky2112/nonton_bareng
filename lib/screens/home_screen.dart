import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/movie_provider.dart';
import 'favorites_screen.dart';
import 'movie_detail.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (movieProvider.popularMovies.isEmpty) {
            return const Center(child: Text('No movies found'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: movieProvider.popularMovies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.popularMovies[index];

              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman detail film saat item diklik
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.title,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
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
                                  color: isFavorite ? Colors.red : Colors.grey,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}

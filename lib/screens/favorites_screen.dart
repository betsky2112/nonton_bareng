import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/movie_model.dart';
import '../providers/favorite_provider.dart';
import 'movie_detail.dart'; // Gantilah ini dengan path yang benar ke provider favorit Anda

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: favoriteProvider.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites yet.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return ListTile(
                title: Text(movie.title),
                onTap: () {
                  // Navigasi ke detail film jika diinginkan
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MovieDetailScreen(movie: movie)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

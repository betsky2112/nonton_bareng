import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Movies...',
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Provider.of<MovieProvider>(context, listen: false)
                    .searchMovies(_searchController.text);
              },
            ),
          ),
        ),
      ),
      body: Consumer<MovieProvider>(builder: (context, movieProvider, child) {
        if (movieProvider.isSearching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (movieProvider.searchResults.isEmpty) {
          return const Center(child: Text('No movies found'));
        }

        return ListView.builder(
          itemCount: movieProvider.searchResults.length,
          itemBuilder: (context, index) {
            final movie = movieProvider.searchResults[index];
            return ListTile(
              leading: movie.posterPath != ''
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/placeholder.png', // Placeholder untuk gambar yang tidak tersedia
                      width: 50, // Ukuran placeholder
                    ),
              title: Text(movie.title),
              subtitle: Text('Rating: ${movie.rating}'),
            );
          },
        );
      }),
    );
  }
}

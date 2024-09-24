class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final double rating;
  final String releaseDate;
  final int runTime;

  Movie(
      {required this.id,
      required this.title,
      required this.overview,
      required this.posterPath,
      required this.rating,
      required this.releaseDate,
      required this.runTime});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      rating: json['vote_average'].toDouble(),
      releaseDate: json['release_date'] ?? '',
      runTime: json['runtime'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'rating': rating,
      'releaseDate': releaseDate,
    };
  }
}

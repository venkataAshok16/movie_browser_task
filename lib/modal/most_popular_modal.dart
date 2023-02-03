class MostPopularModal {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MostPopularModal(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  factory MostPopularModal.fromJson(Map<String, dynamic> json) {
    print(json);
    return MostPopularModal(
        backdropPath: (json['backdrop_path'] != null) ? ('http://image.tmdb.org/t/p/w500${json['backdrop_path']}') : "assets/images/movie_poster.png",
        id: json['id'],
        originalTitle: json['original_title'],
        popularity: json['popularity'] ?? 0.0,
        posterPath: (json['poster_path'] != null) ? ('http://image.tmdb.org/t/p/w500${json['poster_path']}') : "assets/images/movie_poster.png",
        releaseDate: json['release_date'],
        title: json['title'],
        voteAverage: (json['vote_average'] is int) ? json['vote_average'].toDouble() : json['vote_average'],
        voteCount: json['vote_count']);
  }
}

class PaginatedModal {
  int page;
  List<MostPopularModal> results;
  int totalPages;
  int totalResults;

  PaginatedModal({required this.page, required this.results, required this.totalPages, required this.totalResults});

  factory PaginatedModal.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['results'];
    return PaginatedModal(
      page: json['page'],
      results: list.map((e) => MostPopularModal.fromJson(e)).toList(),
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
    );
  }
}

enum MovieListCategory {
  nowPlaying,
  upcoming,
}

class GetMovieListParam {
  final int page;
  final MovieListCategory category;

  GetMovieListParam({
    required this.category,
    this.page = 1,
  });
}

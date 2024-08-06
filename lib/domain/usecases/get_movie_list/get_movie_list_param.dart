enum MovieListCategory {
  nowPlaying,
  upcoming,
  popular,
}

class GetMovieListParam {
  final int page;
  final MovieListCategory category;

  GetMovieListParam({
    required this.category,
    this.page = 1,
  });
}

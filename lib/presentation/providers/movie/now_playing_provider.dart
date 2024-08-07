import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'now_playing_provider.g.dart';

/// A Riverpod provider for managing the state of movies currently playing.
///
/// Uses the [GetMovieList] use case to fetch the list of movies currently playing.
@Riverpod(keepAlive: true)
class NowPlaying extends _$NowPlaying {
  @override
  FutureOr<List<Movie>> build() => const [];

  /// Fetches a list of movies currently playing and updates the state.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();
    // Retrieve the [GetMovieList] use case from the provider
    GetMovieList getMovieList = ref.read(getMovieListProvider);
    // Execute the use case to fetch the list of movies currently playing
    var result = await getMovieList(
      GetMovieListParam(
        category: MovieListCategory.nowPlaying,
      ),
    );

    switch (result) {
      case Success(value: final movie):
        state = AsyncData(movie);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}

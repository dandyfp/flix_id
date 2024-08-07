import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_provider.g.dart';

/// Provider using riverpod for provide state from API to UI
@Riverpod(keepAlive: true)
class Popular extends _$Popular {
  @override
  FutureOr<List<Movie>> build() => const [];

  /// Func get movies
  Future<void> getMovies({int page = 1}) async {
    /// Change state to loading
    state = const AsyncLoading();

    /// Create instance from class usecase
    GetMovieList getMovieList = ref.read(getMovieListProvider);
    var result = await getMovieList(
      GetMovieListParam(
        category: MovieListCategory.popular,
      ),
    );

    switch (result) {
      case Success(value: final movie):

        /// Change state if data movie not null or empty
        state = AsyncData(movie);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}

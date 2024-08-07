import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'upcoming_provider.g.dart';

/// A Riverpod provider for managing the state of upcoming movies.
///
/// Uses the [GetMovieList] use case to fetch the list of upcoming movies.
@Riverpod(keepAlive: true)
class Upcoming extends _$Upcoming {
  @override
  FutureOr<List<Movie>> build() => const [];

  /// Fetches a list of upcoming movies and updates the state.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  Future<void> getMovies({int page = 1}) async {
    state = const AsyncLoading();
    // Retrieve the [GetMovieList] use case from the provider
    GetMovieList getMovieList = ref.read(getMovieListProvider);
    // Execute the use case to fetch the list of upcoming movies
    var result = await getMovieList(
      GetMovieListParam(
        category: MovieListCategory.upcoming,
      ),
    );
    // Update the state based on the result
    switch (result) {
      case Success(value: final movie):
        state = AsyncData(movie); // Update state with the list of movies
      case Failed(message: _):
        state = const AsyncData([]); // Set state to an empty list on failure
    }
  }
}

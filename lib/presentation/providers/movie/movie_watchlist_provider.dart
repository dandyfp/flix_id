import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist.dart';
import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_watchlist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_watchlist_provider.g.dart';

/// A Riverpod provider for managing the state of a user's movie watchlist.
///
/// Uses the [GetWatchList] use case to fetch the list of movies in the user's watchlist
@Riverpod(keepAlive: true)
class MovieWatchlist extends _$MovieWatchlist {
  @override
  Future<List<Movie>> build() async {
    return [];
  }

  /// Fetches the user's movie watchlist and updates the state.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  Future<void> getWatchListMovie({int page = 1}) async {
    // Retrieve the current user from the user data provider
    User? user = ref.read(userDataProvider).valueOrNull;
    state = const AsyncLoading();
    // Retrieve the [GetWatchList] use case from the provider
    GetWatchList getWatchList = ref.read(getWatchListProvider);
    // Execute the use case to fetch the user's watchlist
    var result = await getWatchList(
      GetWatchlistParam(
        uid: user?.uid ?? '',
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

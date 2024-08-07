import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist.dart';
import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_watchlist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_watchlist_provider.g.dart';

@Riverpod(keepAlive: true)
class MovieWatchlist extends _$MovieWatchlist {
  @override
  Future<List<Movie>> build() async {
    return [];
  }

  Future<void> getWatchListMovie({int page = 1}) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    state = const AsyncLoading();

    GetWatchList getWatchList = ref.read(getWatchListProvider);

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

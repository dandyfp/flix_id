import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/add_watchlist/add_watchlist_param.dart';
import 'package:flix_id/presentation/providers/usecase/add_watchlist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_watchlist_movie_provider.g.dart';

@Riverpod(keepAlive: true)
class AddWatchlistMovie extends _$AddWatchlistMovie {
  @override
  Future<Result<void>?> build() async {
    return null;
  }

  Future<void> addWatchlistMovie(
    Movie movie,
  ) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    var addWatchList = ref.read(addWatchlistProvider);
    var result = await addWatchList(
        AddWatchinglistParam(movie: movie, uid: user?.uid ?? ''));

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}

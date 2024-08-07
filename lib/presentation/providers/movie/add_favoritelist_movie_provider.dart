import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/add_favorite/add_favorite_param.dart';
import 'package:flix_id/presentation/providers/usecase/add_favoritelist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_favoritelist_movie_provider.g.dart';

/// A Riverpod provider for adding movies to the favorite list.
@Riverpod(keepAlive: true)
class AddFavoritelistMovie extends _$AddFavoritelistMovie {
  @override
  Future<Result<void>?> build() async {
    return null;
  }

  /// Adds a movie to the favorite list.
  ///
  /// This method fetches the current user, reads the `addWatchlistProvider`,
  /// and attempts to add the specified [movie] to the watchlist.
  ///
  /// If the addition is successful, the state is set to `AsyncData` with null.
  /// If it fails, the state is set to `AsyncError` with the error message,
  /// and then reset to `AsyncData` with null.
  Future<void> addFavoriteMovie(
    Movie movie,
  ) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    var addFavoriteList = ref.read(addFavoritelistProvider);
    var result = await addFavoriteList(
        AddFavoritelistParam(movie: movie, uid: user?.uid ?? ''));

    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}

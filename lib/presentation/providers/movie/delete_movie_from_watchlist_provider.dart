import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/delete_movie_from_watchlist/delete_movie_from_watchlist_param.dart';
import 'package:flix_id/presentation/providers/movie/movie_watchlist_provider.dart';
import 'package:flix_id/presentation/providers/usecase/delete_movie_from_watchlist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_movie_from_watchlist_provider.g.dart';

@Riverpod(keepAlive: true)
class DeleteMovieWatchlist extends _$DeleteMovieWatchlist {
  @override
  Future<Result<void>?> build() async {
    return null;
  }

  Future<void> deleteMovie(
    Movie movie,
  ) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    var deleteMovie = ref.read(deleteMovieFromWatchlistProvider);
    var result = await deleteMovie(DeleteMovieFromWatchlistParam(
        movieId: movie.id.toString(), uid: user?.uid ?? ''));

    switch (result) {
      case Success(value: _):
        ref.read(movieWatchlistProvider.notifier).getWatchListMovie();
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}

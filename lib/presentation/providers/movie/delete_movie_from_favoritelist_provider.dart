import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/delete_movie_from_favoritelist/delete_movie_from_favoritelist_param.dart';
import 'package:flix_id/presentation/providers/movie/movie_favoritelist_provider.dart';
import 'package:flix_id/presentation/providers/usecase/delete_movie_from_favoritelist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_movie_from_favoritelist_provider.g.dart';

/// A Riverpod provider class for managing the deletion of movies from the favorite list.
@Riverpod(keepAlive: true)
class DeleteDataMovieFavoritelist extends _$DeleteDataMovieFavoritelist {
  /// Initializes the state of the provider.
  ///
  /// This method is required by Riverpod but is not used in this case.
  @override
  Future<Result<void>?> build() async {
    return null;
  }

  /// Deletes a movie from the favorite list.
  ///
  /// This method retrieves the current user from the [userDataProvider],
  /// reads the [deleteMovieFavoritelistProvider] use case, and attempts to
  /// delete the specified [movie] from the user's favorite list.
  ///
  /// After successfully deleting the movie, it refreshes the favorite list
  /// by calling [getFavoriteListMovie] from the [movieFavoritelistProvider].
  /// The state is then set to [AsyncData] with null.
  ///
  /// If the operation fails, the state is set to [AsyncError] with the error
  /// message and then reset to [AsyncData] with null.
  ///
  /// [movie] The movie to be removed from the favorite list.
  Future<void> deleteMovie(
    Movie movie,
  ) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    var deleteMovie = ref.read(deleteMovieFavoritelistProvider);
    var result = await deleteMovie(DeleteMovieFavoritelistParam(
        movieId: movie.id.toString(), uid: user?.uid ?? ''));

    switch (result) {
      case Success(value: _):
        ref.read(movieFavoritelistProvider.notifier).getFavoriteListMovie();
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }
}

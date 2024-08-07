import 'package:flix_id/domain/usecases/delete_movie_from_watchlist/delete_movie_from_watchlist.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_movie_from_watchlist_provider.g.dart';

@riverpod
DeleteMovieFromWatchlist deleteMovieFromWatchlist(
        DeleteMovieFromWatchlistRef ref) =>
    DeleteMovieFromWatchlist(userRepository: ref.watch(userRepositoryProvider));

import 'package:flix_id/domain/usecases/delete_movie_from_favoritelist/delete_movie_from_favoritelist.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_movie_from_favoritelist_provider.g.dart';

@riverpod
DeleteMovieFavoritelist deleteMovieFavoritelist(
        DeleteMovieFavoritelistRef ref) =>
    DeleteMovieFavoritelist(userRepository: ref.watch(userRepositoryProvider));

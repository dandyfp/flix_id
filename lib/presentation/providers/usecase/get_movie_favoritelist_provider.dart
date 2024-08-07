import 'package:flix_id/domain/usecases/get_favoritelist/get_favoritelist.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_favoritelist_provider.g.dart';

@riverpod
GetFavoriteList getFavoriteList(GetFavoriteListRef ref) =>
    GetFavoriteList(userRepository: ref.watch(userRepositoryProvider));

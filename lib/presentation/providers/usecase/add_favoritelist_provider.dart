import 'package:flix_id/domain/usecases/add_favorite/add_favorite.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_favoritelist_provider.g.dart';

@riverpod
AddFavoritelist addFavoritelist(AddFavoritelistRef ref) =>
    AddFavoritelist(userRepository: ref.watch(userRepositoryProvider));

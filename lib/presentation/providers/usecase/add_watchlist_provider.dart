import 'package:flix_id/domain/usecases/add_watchlist/add_watchlist.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_watchlist_provider.g.dart';

@riverpod
AddWatchlist addWatchlist(AddWatchlistRef ref) =>
    AddWatchlist(userRepository: ref.watch(userRepositoryProvider));

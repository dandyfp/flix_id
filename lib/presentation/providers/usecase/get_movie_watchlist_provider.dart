import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist.dart';
import 'package:flix_id/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_watchlist_provider.g.dart';

@riverpod
GetWatchList getWatchList(GetWatchListRef ref) =>
    GetWatchList(userRepository: ref.watch(userRepositoryProvider));

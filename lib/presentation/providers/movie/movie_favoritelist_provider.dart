import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/entities/user.dart';
import 'package:flix_id/domain/usecases/get_favoritelist/get_favoritelist.dart';
import 'package:flix_id/domain/usecases/get_favoritelist/get_favoritelist_param.dart';
import 'package:flix_id/presentation/providers/usecase/get_movie_favoritelist_provider.dart';
import 'package:flix_id/presentation/providers/user_data/user_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_favoritelist_provider.g.dart';

@Riverpod(keepAlive: true)
class MovieFavoritelist extends _$MovieFavoritelist {
  @override
  Future<List<Movie>> build() async {
    return [];
  }

  Future<void> getFavoriteListMovie({int page = 1}) async {
    User? user = ref.read(userDataProvider).valueOrNull;
    state = const AsyncLoading();

    GetFavoriteList getFavoriteList = ref.read(getFavoriteListProvider);

    var result = await getFavoriteList(
      GetFavoritelistParam(
        uid: user?.uid ?? '',
      ),
    );

    switch (result) {
      case Success(value: final movie):
        state = AsyncData(movie);
      case Failed(message: _):
        state = const AsyncData([]);
    }
  }
}

import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/delete_movie_from_favoritelist/delete_movie_from_favoritelist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class DeleteMovieFavoritelist
    implements UseCase<Result<void>, DeleteMovieFavoritelistParam> {
  final UserRepository _userRepository;

  DeleteMovieFavoritelist({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<void>> call(DeleteMovieFavoritelistParam params) async {
    return await _userRepository.deleteMovieFromFavorite(
      movieId: params.movieId,
      uid: params.uid,
    );
  }
}

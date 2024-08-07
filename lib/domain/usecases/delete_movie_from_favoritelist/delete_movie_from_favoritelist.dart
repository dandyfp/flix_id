import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/delete_movie_from_favoritelist/delete_movie_from_favoritelist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

/// A use case class for removing a movie from the user's favorites list.
///
/// Implements the [UseCase] interface with [Result<void>] as the result type and
/// [DeleteMovieFavoritelistParam] as the parameter type.
class DeleteMovieFavoritelist
    implements UseCase<Result<void>, DeleteMovieFavoritelistParam> {
  final UserRepository _userRepository;

  /// Creates an instance of [DeleteMovieFavoritelist].
  ///
  /// [userRepository] is required and is used to interact with the data layer.
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

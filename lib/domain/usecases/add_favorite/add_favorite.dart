import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/add_favorite/add_favorite_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

/// A use case class for adding a movie to the user's favorites list.
///
/// Implements the [UseCase] interface with [Result<void>] as the result type and
/// [AddFavoritelistParam] as the parameter type.
class AddFavoritelist implements UseCase<Result<void>, AddFavoritelistParam> {
  final UserRepository _userRepository;

  /// Creates an instance of [AddFavoritelist].
  ///
  /// [userRepository] is required and is used to interact with the data layer.
  AddFavoritelist({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<void>> call(AddFavoritelistParam params) async {
    return await _userRepository.addToFavorite(
      uid: params.uid,
      movie: params.movie,
    );
  }
}

import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/add_favorite/add_favorite_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class AddFavoritelist implements UseCase<Result<void>, AddFavoritelistParam> {
  final UserRepository _userRepository;

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

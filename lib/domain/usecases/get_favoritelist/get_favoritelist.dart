import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_favoritelist/get_favoritelist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class GetFavoriteList
    implements UseCase<Result<List<Movie>>, GetFavoritelistParam> {
  final UserRepository _userRepository;

  GetFavoriteList({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<List<Movie>>> call(GetFavoritelistParam params) async {
    var result = await _userRepository.getFavoriteList(params.uid);
    return switch (result) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message),
    };
  }
}

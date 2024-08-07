import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_watchinglist/get_watchinglist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class GetWatchingList
    implements UseCase<Result<List<Movie>>, GetWatchinglistParam> {
  final UserRepository _userRepository;

  GetWatchingList({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<List<Movie>>> call(GetWatchinglistParam params) async {
    var result = await _userRepository.getWatchlist(params.uid);
    return switch (result) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message),
    };
  }
}

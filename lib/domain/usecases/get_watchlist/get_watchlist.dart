import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/get_watchlist/get_watchlist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class GetWatchList implements UseCase<Result<List<Movie>>, GetWatchlistParam> {
  final UserRepository _userRepository;

  GetWatchList({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<List<Movie>>> call(GetWatchlistParam params) async {
    var result = await _userRepository.getWatchlist(params.uid);
    return switch (result) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message),
    };
  }
}

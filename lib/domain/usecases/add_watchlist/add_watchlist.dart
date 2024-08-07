import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/add_watchlist/add_watchlist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class AddWatchlist implements UseCase<Result<void>, AddWatchinglistParam> {
  final UserRepository _userRepository;

  AddWatchlist({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<void>> call(AddWatchinglistParam params) async {
    return await _userRepository.addToWatchlist(
      uid: params.uid,
      movie: params.movie,
    );
  }
}

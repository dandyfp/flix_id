import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/add_watchlist/add_watchlist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

/// A use case class for adding a movie to the user's watchlist.
///
/// Implements the [UseCase] interface with [Result<void>] as the result type and
/// [AddWatchinglistParam] as the parameter type.
class AddWatchlist implements UseCase<Result<void>, AddWatchinglistParam> {
  final UserRepository _userRepository;

  /// Creates an instance of [AddWatchlist].
  ///
  /// [userRepository] is required and is used to interact with the data layer.
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

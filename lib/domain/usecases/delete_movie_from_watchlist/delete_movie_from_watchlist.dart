import 'package:flix_id/data/repositories/user_repository.dart';
import 'package:flix_id/domain/entities/result.dart';
import 'package:flix_id/domain/usecases/delete_movie_from_watchlist/delete_movie_from_watchlist_param.dart';
import 'package:flix_id/domain/usecases/usecase.dart';

class DeleteMovieFromWatchlist
    implements UseCase<Result<void>, DeleteMovieFromWatchlistParam> {
  final UserRepository _userRepository;

  DeleteMovieFromWatchlist({required UserRepository userRepository})
      : _userRepository = userRepository;
  @override
  Future<Result<void>> call(DeleteMovieFromWatchlistParam params) async {
    return await _userRepository.deleteMovieFromWatchlist(
      movieId: params.movieId,
      uid: params.uid,
    );
  }
}

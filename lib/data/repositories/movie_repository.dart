import 'package:flix_id/domain/entities/actor.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';

/// An abstract interface class for movie-related operations.
abstract interface class MovieRepository {
  /// Retrieves a list of movies that are currently playing in theaters.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});

  /// Retrieves a list of upcoming movies.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<List<Movie>>> getUpcoming({int page = 1});

  /// Retrieves a list of popular movies.
  ///
  /// [page] specifies the page number for pagination. Defaults to 1.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<List<Movie>>> getPopular({int page = 1});

  /// Retrieves detailed information about a movie for the given [id].
  ///
  /// Returns [Result.success] with a [MovieDetail] object if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<MovieDetail>> getDetail({required int id});

  /// Retrieves a list of actors for a given movie [id].
  ///
  /// Returns [Result.success] with a list of [Actor] objects if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<List<Actor>>> getActors({required int id});
}

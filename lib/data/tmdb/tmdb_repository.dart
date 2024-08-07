import 'package:dio/dio.dart';
import 'package:flix_id/data/repositories/movie_repository.dart';
import 'package:flix_id/domain/entities/actor.dart';
import 'package:flix_id/domain/entities/movie.dart';
import 'package:flix_id/domain/entities/movie_detail.dart';
import 'package:flix_id/domain/entities/result.dart';

/// Implementation of [MovieRepository] using TMDB (The Movie Database) API.
class TmdbRepository implements MovieRepository {
  final Dio? _dio;

  /// Constructor for [TmdbRepository].
  ///
  /// [dio] is an instance of [Dio] used for making HTTP requests.
  /// If not provided, a default instance will be used.
  TmdbRepository({Dio? dio}) : _dio = dio ?? Dio();

  /// Access token for authenticating with the TMDB API.
  final String accessToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYzZiYTgyYWM0NWJjMzNkMzc2MjM0MjM2MGYxYjNjYyIsInN1YiI6IjY0ZmIzZDE3ZGI0ZWQ2MTAzODUzYmU0ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.wG0uLYTdv9bxxhFwYYpUybAb74qgjj4DZvV1VQfF2hs";

  /// Options for HTTP requests, including headers for authorization and content type.
  late final Options _options = Options(headers: {
    'authorization': 'Bearer $accessToken',
    'accept': 'application/json',
  });

  /// Retrieves a list of actors for a given movie [id].
  ///
  /// Returns [Result.success] with a list of [Actor] objects if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      var response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id/credits?language=en-US',
        options: _options,
      );

      final results = List<Map<String, dynamic>>.from(response.data['cast']);
      return Result.success(results.map((e) => Actor.formJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  /// Retrieves the details of a movie for a given [id].
  ///
  /// Returns [Result.success] with a [MovieDetail] object if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      var response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$id?language=en-US',
        options: _options,
      );
      return Result.success(MovieDetail.fromJSON(response.data));
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  /// Retrieves a list of now playing movies.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) => _getMovies(
        _MovieCategory.nowPlaying.toString(),
        page: page,
      );

  /// Retrieves a list of upcoming movies.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) => _getMovies(
        _MovieCategory.upcoming.toString(),
        page: page,
      );

  /// Retrieves a list of popular movies.
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  @override
  Future<Result<List<Movie>>> getPopular({int page = 1}) => _getMovies(
        _MovieCategory.popular.toString(),
        page: page,
      );

  /// Helper method to retrieve a list of movies for a given [category] and [page].
  ///
  /// Returns [Result.success] with a list of [Movie] objects if successful,
  /// or [Result.failed] with an error message if failed.
  Future<Result<List<Movie>>> _getMovies(
    String category, {
    int page = 1,
  }) async {
    try {
      final response = await _dio!.get(
        'https://api.themoviedb.org/3/movie/$category?language=en-US&page=$page',
        options: _options,
      );

      final results = List<Map<String, dynamic>>.from(response.data['results']);
      return Result.success(results.map((e) => Movie.fromJSON(e)).toList());
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

/// Enum representing movie categories.
enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming'),
  popular('popular');

  final String _instring;

  const _MovieCategory(String inString) : _instring = inString;

  @override
  String toString() => _instring;
}

import 'package:flix_id/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:flix_id/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_movie_list_provider.g.dart';

/// A provider function for the GetMovieList use case.
///
/// This function returns an instance of GetMovieList by watching the
/// [movieRepositoryProvider] and passing it to the constructor of
/// [GetMovieList]. This allows the GetMovieList use case to access
/// the movie repository.
@riverpod
GetMovieList getMovieList(GetMovieListRef ref) =>
    GetMovieList(movieRepository: ref.watch(movieRepositoryProvider));

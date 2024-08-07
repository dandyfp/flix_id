import 'package:flix_id/domain/entities/movie.dart';

class AddWatchinglistParam {
  Movie movie;
  String uid;
  AddWatchinglistParam({
    required this.movie,
    required this.uid,
  });
}

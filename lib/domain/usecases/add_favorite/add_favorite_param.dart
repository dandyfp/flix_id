import 'package:flix_id/domain/entities/movie.dart';

class AddFavoritelistParam {
  Movie movie;
  String uid;
  AddFavoritelistParam({
    required this.movie,
    required this.uid,
  });
}

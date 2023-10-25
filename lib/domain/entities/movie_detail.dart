import 'package:freezed_annotation/freezed_annotation.dart';
part 'movie_detail.freezed.dart';

@freezed
class MovieDetail with _$MovieDetail {
  const factory MovieDetail({
    required int id,
    required String title,
    String? posterPath,
    required String overview,
    String? backdropPath,
    required int runtime,
    required double voteAverage,
    required List<String> genres,
  }) = _Moviedetail;

  factory MovieDetail.fromJSON(Map<String, dynamic> json) => MovieDetail(
        id: json["id"],
        title: json["title"],
        overview: json["overview"],
        runtime: json["runtime"],
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        genres: List<String>.from(json["genres"].map((e) => e["name"])),
        backdropPath: json["backdrop_path"],
        posterPath: json["poster_path"],
      );
}

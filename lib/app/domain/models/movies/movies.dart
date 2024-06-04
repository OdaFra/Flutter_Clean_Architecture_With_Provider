import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/typedefs.dart';
import '../genre/genre.dart';
import '../media/media.dart';

part 'movies.freezed.dart';
part 'movies.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    required List<Genre> genres,
    required String overview,
    required int runtime,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'release_date') required DateTime releaseDate,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(readValue: readOriginalValue) required String originalTitle,
    @JsonKey(name: 'backdrop_path') required String? backdropPath,
  }) = _Movie;
  const Movie._();

  factory Movie.fromJson(Json json) => _$MovieFromJson(json);

  Media toMedia() {
    return Media(
      id: id,
      overview: overview,
      title: title,
      originalTitle: originalTitle,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      type: MediaType.movie,
    );
  }
}

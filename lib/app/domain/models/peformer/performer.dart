import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/typedefs.dart';
import '../media/media.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,
    @JsonKey(name: 'original_name') required String originalName,
    @JsonKey(name: 'profile_path') required String profilePath,
    @JsonKey(name: 'know_for', fromJson: getMediaList)
    required List<Media> knowFor,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}
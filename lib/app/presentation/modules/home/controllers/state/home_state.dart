import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/enums/enum.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/peformer/performer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.loading(TimeWindow timeWindow) = HomeStateLoading;
  factory HomeState.failed(TimeWindow timeWindow) = HomeStateFailed;
  factory HomeState.loaded({
    required TimeWindow timeWindow,
    required List<Media> moviesAndSeries,
    required List<Performer> performes,
  }) = HomeStateLoaded;
  // factory HomeState({
  //   required bool loading,
  //   List<Media>? moviesAndSeries,
  //   @Default(TimeWindow.day) TimeWindow timeWindow,
  // }) = _HomeState;

  // factory HomeState.fromJson(Map<String, dynamic> json) => _$HomeStateFromJson(json);
}

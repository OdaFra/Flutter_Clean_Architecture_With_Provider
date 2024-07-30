import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/enums/enums.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/peformer/performer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(MoviesAndSeriesState.loading(
      TimeWindow.day,
    ))
    MoviesAndSeriesState moviesAndSeriesState,
    @Default(
      PerformersState.loading(),
    )
    PerformersState performersState,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(TimeWindow timeWindow) =
      MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.failed(TimeWindow timeWindow) =
      MoviesAndSeriesStateFailed;
  const factory MoviesAndSeriesState.loaded({
    required TimeWindow timeWindow,
    required List<Media> list,
  }) = MoviesAndSeriesStateLoaded;
  // factory MoviesAndSeriesState({
  //   required bool loading,
  //   List<Media>? moviesAndSeries,
  //   @Default(TimeWindow.day) TimeWindow timeWindow,
  // }) = _MoviesAndSeriesState;

  // factory MoviesAndSeriesState.fromJson(Map<String, dynamic> json) => _$MoviesAndSeriesStateFromJson(json);
}

@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading() = PerformersStateLoading;
  const factory PerformersState.failed() = PerformersStateFailure;
  const factory PerformersState.loaded(
    List<Performer> list,
  ) = PerformersStateLoaded;
}

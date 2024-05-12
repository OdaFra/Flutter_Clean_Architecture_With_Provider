import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/media/media.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  factory FavoriteState.loading() = FavoriteStateLoading;
  factory FavoriteState.failed() = FavoriteStateFailed;
  factory FavoriteState.loaded({
    required Map<int, Media> movies,
    required Map<int, Media> series,
  }) = FavoriteStateLoaded;
}

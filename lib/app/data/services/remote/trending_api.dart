import '../../../core/enums/enum.dart';
import '../../../core/utils/utils.dart';
import '../../../domain/models/media/media.dart';
import '../../http/HttpManagement.dart';

class TrendingApi {
  final HttpManagement _http;

  TrendingApi(this._http);

  getMoviesAndSeries(TimeWindow timeWindow) async {
    final result = await _http.request('/trending/all/${timeWindow.name}',
        onSuccess: (json) {
      final mediaList = json['result'] as List<Json>;

      final items = mediaList
          .where(
            (type) => type['media_type'] != 'person',
          )
          .map((e) => Media.fromJson(
                e,
              ))
          .toList();
      return items;
    });
  }
}

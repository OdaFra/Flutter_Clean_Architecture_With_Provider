// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/enums/preferenceTheme.dart';
import '../../domain/repositories/preferences_repository.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final SharedPreferences _preferences;
  PreferencesRepositoryImpl(this._preferences);
  @override
  bool? get darkMode {
    return _preferences.getBool(
      Preferencetheme.darkMode.name,
    );
  }

  @override
  Future<void> setDarkMode(bool darkMode) async {
    await _preferences.setBool(
      Preferencetheme.darkMode.name,
      darkMode,
    );
  }
}

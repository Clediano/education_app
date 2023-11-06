import 'package:education_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDatasource {
  const OnboardingLocalDatasource();

  Future<void> cacheFirstTime();

  Future<bool> checkIfUserIsFirstTime();
}

const kFirstTimeKey = 'is_first_time';

class OnboardingLocalDataSourceImpl extends OnboardingLocalDatasource {
  OnboardingLocalDataSourceImpl(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<void> cacheFirstTime() async {
    try {
      await _preferences.setBool(kFirstTimeKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTime() async {
    try {
      return _preferences.getBool(kFirstTimeKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}

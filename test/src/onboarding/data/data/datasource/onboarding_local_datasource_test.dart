import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnboardingLocalDatasource localDatasource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDatasource = OnboardingLocalDataSourceImpl(prefs);
  });

  group('cacheFirstTime', () {
    test('should call [SharedPreferences] to cache the data', () async {
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      await localDatasource.cacheFirstTime();

      verify(() => prefs.setBool(kFirstTimeKey, false));
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] '
        'when there is an error caching the data', () async {
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      final methodCall = localDatasource.cacheFirstTime;

      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.setBool(kFirstTimeKey, false)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIfFirstTime', () {
    test(
        'should call [SharedPreferences] to call if user is first time '
        'and return the right response from storage when data exists',
        () async {
      when(() => prefs.getBool(any())).thenReturn(false);

      final result = await localDatasource.checkIfUserIsFirstTime();

      expect(result, isFalse);
      verify(() => prefs.getBool(kFirstTimeKey));
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      when(() => prefs.getBool(any())).thenReturn(null);

      final result = await localDatasource.checkIfUserIsFirstTime();

      expect(result, isTrue);
      verify(() => prefs.getBool(kFirstTimeKey));
      verifyNoMoreInteractions(prefs);
    });
    test(
        'should throw a [CacheException] when there is an error '
        'retrieving the data', () async {
      when(() => prefs.getBool(any())).thenThrow(Exception());

      final methodCall = localDatasource.checkIfUserIsFirstTime;

      expect(methodCall, throwsA(isA<CacheException>()));
      verify(() => prefs.getBool(kFirstTimeKey)).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });
}

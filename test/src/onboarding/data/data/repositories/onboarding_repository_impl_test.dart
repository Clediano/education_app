import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app/src/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDatasource extends Mock
    implements OnboardingLocalDatasource {}

void main() {
  late OnboardingLocalDatasource localDatasource;
  late OnboardingRepositoryImpl repositoryImpl;

  setUp(() {
    localDatasource = MockOnboardingLocalDatasource();
    repositoryImpl = OnboardingRepositoryImpl(localDatasource);
  });

  group('cacheFirstTime', () {
    test(
        'should complete successfully when call to local data source is successful',
        () async {
      when(() => localDatasource.cacheFirstTime())
          .thenAnswer((_) async => Future.value());

      final result = await repositoryImpl.cacheFirstTime();

      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDatasource.cacheFirstTime()).called(1);
      verifyNoMoreInteractions(localDatasource);
    });

    test(
        'should return a [CacheFailure] '
        'when call to local source is unsuccessfully', () async {
      when(() => localDatasource.cacheFirstTime()).thenThrow(
        const CacheException(message: 'Insufficient Storage'),
      );

      final result = await repositoryImpl.cacheFirstTime();

      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(message: 'Insufficient Storage', statusCode: 500),
        ),
      );
      verify(() => localDatasource.cacheFirstTime()).called(1);
      verifyNoMoreInteractions(localDatasource);
    });
  });

  group('checkIfUserIfFirstTime', () {
    test(
      'should return true if user is first time',
      () async {
        when(() => localDatasource.checkIfUserIsFirstTime())
            .thenAnswer((_) async => Future.value(true));

        final result = await repositoryImpl.checkIfUserIsFirstTime();

        expect(result, equals(const Right<dynamic, bool>(true)));
        verify(() => localDatasource.checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(localDatasource);
      },
    );

    test(
      'should return false if user is not first time',
      () async {
        when(() => localDatasource.checkIfUserIsFirstTime())
            .thenAnswer((_) async => Future.value(false));

        final result = await repositoryImpl.checkIfUserIsFirstTime();

        expect(result, equals(const Right<dynamic, bool>(false)));
        verify(() => localDatasource.checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(localDatasource);
      },
    );

    test(
        'should return a [CacheFailure] '
        'when call to local source is unsuccessfully', () async {
      when(() => localDatasource.checkIfUserIsFirstTime()).thenThrow(
        const CacheException(message: 'Insufficient Storage'),
      );

      final result = await repositoryImpl.checkIfUserIsFirstTime();

      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient Storage', statusCode: 500),
          ),
        ),
      );
      verify(() => localDatasource.checkIfUserIsFirstTime()).called(1);
      verifyNoMoreInteractions(localDatasource);
    });
  });
}

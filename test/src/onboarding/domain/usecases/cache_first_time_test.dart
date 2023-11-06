import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repo;
  late CacheFirstTime usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTime(repo);
  });

  test(
      'should call the [OnboardingRepository.cacheFirstTime] '
      'and return ServerFailure', () async {
    when(() => repo.cacheFirstTime()).thenAnswer(
      (_) async => Left(
        ServerFailure(
          message: 'Unknown error',
          statusCode: 500,
        ),
      ),
    );

    final result = await usecase();

    expect(
      result,
      equals(
        Left<Failure, dynamic>(
          ServerFailure(
            message: 'Unknown error',
            statusCode: 500,
          ),
        ),
      ),
    );
    verify(() => repo.cacheFirstTime()).called(1);
    verifyNoMoreInteractions(repo);
  });
}

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repository.mock.dart';

void main() {
  late OnboardingRepository repo;
  late CheckIfUserIsFirstTime usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTime(repo);
  });

  test('should get a response from the [OnboardingRepo.checkIfUserIsFirstTime]',
      () async {
    when(() => repo.checkIfUserIsFirstTime())
        .thenAnswer((_) async => const Right(true));

    final result = await usecase();

    expect(result, equals(const Right<dynamic, bool>(true)));
    verify(() => repo.checkIfUserIsFirstTime()).called(1);
    verifyNoMoreInteractions(repo);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:education_app/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTime extends Mock implements CacheFirstTime {}

class MockCheckIfUserIsFirstTime extends Mock
    implements CheckIfUserIsFirstTime {}

void main() {
  late CacheFirstTime cacheFirstTime;
  late CheckIfUserIsFirstTime checkIfUserIsFirstTime;
  late OnboardingCubit cubit;

  setUp(() {
    cacheFirstTime = MockCacheFirstTime();
    checkIfUserIsFirstTime = MockCheckIfUserIsFirstTime();
    cubit = OnboardingCubit(
      cacheFirstTime: cacheFirstTime,
      checkIfUserIsFirstTime: checkIfUserIsFirstTime,
    );
  });

  final tFailure = CacheFailure(
    message: 'Fail to save the data',
    statusCode: 500,
  );

  test('initial state should be [OnboardingInitial]', () {
    expect(cubit.state, const OnboardingInitial());
  });

  group('cacheFirstTime', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CachingFirstTimer, UserCached] when successful',
      build: () {
        when(() => cacheFirstTime()).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => const [
        CachingFirstTime(),
        UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CachingState, OnboardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTime()).thenAnswer((_) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => [
        const CachingFirstTime(),
        OnboardingError(tFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );
  });

  group('checkIfUserIsFirstTime', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckingIfUserIsFirstTime, OnboardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTime()).thenAnswer(
          (_) async => const Right(false),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => const [
        CheckingIfUserIsFirstTime(),
        OnboardingStatus(isFirstTime: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckingIfUserIsFirstTime, OnboardingStatus(true)] '
      'when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTime()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => const [
        CheckingIfUserIsFirstTime(),
        OnboardingStatus(isFirstTime: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );
  });
}

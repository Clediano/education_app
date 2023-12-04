import 'package:bloc/bloc.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CacheFirstTime cacheFirstTime,
    required CheckIfUserIsFirstTime checkIfUserIsFirstTime,
  })  : _cacheFirstTime = cacheFirstTime,
        _checkIfUserIsFirstTime = checkIfUserIsFirstTime,
        super(const OnboardingInitial());

  final CacheFirstTime _cacheFirstTime;
  final CheckIfUserIsFirstTime _checkIfUserIsFirstTime;

  Future<void> cacheFirstTime() async {
    emit(const CachingFirstTime());
    final result = await _cacheFirstTime();

    result.fold(
      (failure) => emit(OnboardingError(failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTime() async {
    emit(const CheckingIfUserIsFirstTime());
    final result = await _checkIfUserIsFirstTime();
    result.fold(
      (failure) => emit(const OnboardingStatus(isFirstTime: true)),
      (status) => emit(OnboardingStatus(isFirstTime: status)),
    );
  }
}

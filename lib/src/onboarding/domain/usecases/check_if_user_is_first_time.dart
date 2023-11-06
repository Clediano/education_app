import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';

class CheckIfUserIsFirstTime extends UsecasesWithoutParams<bool> {
  CheckIfUserIsFirstTime(this._repo);

  final OnboardingRepository _repo;

  @override
  ResultFuture<bool> call() {
    return _repo.checkIfUserIsFirstTime();
  }
}

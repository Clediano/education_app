import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';

class CacheFirstTime extends UsecasesWithoutParams<void> {
  const CacheFirstTime(this._repo);

  final OnboardingRepository _repo;

  @override
  ResultFuture<void> call() async {
    return _repo.cacheFirstTime();
  }
}

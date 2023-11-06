import 'package:education_app/core/utils/typedefs.dart';

abstract class OnboardingRepository {
  ResultFuture<void> cacheFirstTime();
  ResultFuture<bool> checkIfUserIsFirstTime();
}

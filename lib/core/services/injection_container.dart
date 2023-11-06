import 'package:education_app/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app/src/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:education_app/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:education_app/src/onboarding/domain/usecases/check_if_user_is_first_time.dart';
import 'package:education_app/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  //Feature > Onboarding
  //Business Logic
  sl
    ..registerFactory(
      () => OnboardingCubit(
        cacheFirstTime: sl(),
        checkIfUserIsFirstTime: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTime(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTime(sl()))
    ..registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(sl()),
    )
    ..registerLazySingleton<OnboardingLocalDatasource>(
      () => OnboardingLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}

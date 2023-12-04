part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onboardingInit();
  await _authInit();
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerFactory(() => SignIn(sl()))
    ..registerFactory(() => SignUp(sl()))
    ..registerFactory(() => ForgotPassword(sl()))
    ..registerFactory(() => UpdateUser(sl()))
    ..registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()),
    )
    ..registerLazySingleton<AuthenticationRemoteDatasource>(
      () => AuthenticationRemoteDatasourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _onboardingInit() async {
  final prefs = await SharedPreferences.getInstance();

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

import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app/src/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._localDatasource);

  final OnboardingLocalDatasource _localDatasource;

  @override
  ResultFuture<void> cacheFirstTime() async {
    try {
      await _localDatasource.cacheFirstTime();
      return const Right(null);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(message: error.message, statusCode: error.statusCode),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTime() async {
    try {
      final result = await _localDatasource.checkIfUserIsFirstTime();
      return Right(result);
    } on CacheException catch (error) {
      return Left(
        CacheFailure(message: error.message, statusCode: error.statusCode),
      );
    }
  }
}

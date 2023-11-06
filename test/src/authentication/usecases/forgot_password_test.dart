import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/forgot_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repo.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late ForgotPassword usecase;

  setUp(() {
    repository = AuthenticationRepositoryMock();
    usecase = ForgotPassword(repository);
  });

  test('should call the [AuthRepo.forgotPassword]', () async {
    when(() => repository.forgotPassword(any())).thenAnswer(
      (_) async => const Right(null),
    );

    final result = await usecase('email@email.com');

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.forgotPassword('email@email.com')).called(1);
    verifyNoMoreInteractions(repository);
  });
}

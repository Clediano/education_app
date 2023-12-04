import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repo.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late SignIn usecase;

  setUp(() {
    repository = AuthenticationRepositoryMock();
    usecase = SignIn(repository);
  });

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tUser = LocalUser.empty();

  test('should return [LocalUser] from the [AuthenticationRepository]',
      () async {
    when(
      () => repository.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Right(tUser));

    final result = await usecase(
      const SignInParams(email: tEmail, password: tPassword),
    );

    expect(result, equals(const Right<dynamic, LocalUser>(tUser)));
    verify(
      () => repository.signIn(email: tEmail, password: tPassword),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

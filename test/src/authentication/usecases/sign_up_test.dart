import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/sign_up.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repo.mock.dart';

void main() {
  late SignUp usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = AuthenticationRepositoryMock();
    usecase = SignUp(repository);
  });

  const tEmail = 'Test email';
  const tPassword = 'Test password';
  const tFullName = 'Test full name';

  test('should call the [AuthenticationRepo.signUp]', () async {
    when(
      () => repository.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      const SignUpParams(
        email: tEmail,
        password: tPassword,
        fullName: tFullName,
      ),
    );

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}

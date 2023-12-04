import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'authentication_repo.mock.dart';

void main() {

  late UpdateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = AuthenticationRepositoryMock();
    usecase = UpdateUser(repository);
    registerFallbackValue(UpdateUserAction.email);
  });
  
  test('should call the AuthenticationRepo.updateUser', () async {
    when(
          () => repository.updateUser(
        action: any(named: 'action'),
        userData: any<dynamic>(named: 'userData'),
      ),
    ).thenAnswer((_) async => const Right(null));

    final result = await usecase(
      const UpdateUserParams(
        action: UpdateUserAction.email,
        userData: 'Test email',
      ),
    );

    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
          () => repository.updateUser(
        action: UpdateUserAction.email,
        userData: 'Test email',
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
  
}

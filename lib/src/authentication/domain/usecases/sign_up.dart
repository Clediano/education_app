import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecasesWithParams<void, SignUpParams> {
  const SignUp(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(SignUpParams params) {
    return _repository.signUp(
      email: params.email,
      fullName: params.fullName,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams(
      {required this.email, required this.password, required this.fullName});

  const SignUpParams.empty()
      : this(
          email: '',
          password: '',
          fullName: '',
        );

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object> get props => [email, password, fullName];
}

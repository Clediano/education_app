part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInEvent extends AuthEvent {
  const SignInEvent({required this.email, required this.password});

  final String password;
  final String email;

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  final String password;
  final String email;
  final String name;

  @override
  List<Object> get props => [email, password, name];
}

class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class UpdateUserEvent extends AuthEvent {
  const UpdateUserEvent({required this.action, required this.userData})
      : assert(
          userData is String || userData is File,
          '[data] must be either a String or a File',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}

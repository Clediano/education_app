import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/authentication/domain/repository/authentication_repository.dart';

class ForgotPassword extends UsecasesWithParams<void, String> {
  const ForgotPassword(this._repository);

  final AuthenticationRepository _repository;

  @override
  ResultFuture<void> call(String params) {
    return _repository.forgotPassword(params);
  }
}

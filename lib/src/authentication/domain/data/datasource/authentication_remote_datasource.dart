import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/domain/data/models/user_model.dart';

abstract class AuthenticationRemoteDatasource {
  const AuthenticationRemoteDatasource();

  Future<void> forgotPassword(String email);

  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  const AuthenticationRemoteDatasourceImpl({
    required FirebaseAuth authClient,
    required FirebaseFirestore cloudStoreClient,
    required FirebaseStorage dbClient,
  })  : _cloudStoreClient = cloudStoreClient,
        _authClient = authClient,
        _dbClient = dbClient;

  final FirebaseAuth _authClient;
  final FirebaseFirestore _cloudStoreClient;
  final FirebaseStorage _dbClient;
}

import 'package:auth/src/data_source/auth_data_source.dart';
import 'package:auth/src/models/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref.watch(authDataSourceProvider));
}

class AuthRepository {
  AuthRepository(this._dataSource);

  final IAuthDataSource _dataSource;

  Future<AuthUser> login() => _dataSource.login();
  Future<AuthUser> loginWithToken() => _dataSource.loginWithToken();
  Future<void> logout() => _dataSource.logout();
}

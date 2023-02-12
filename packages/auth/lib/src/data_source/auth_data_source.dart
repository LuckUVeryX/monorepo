import 'dart:math';

import 'package:auth/src/models/auth_failure.dart';
import 'package:auth/src/models/auth_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_data_source.g.dart';

@riverpod
IAuthDataSource authDataSource(AuthDataSourceRef ref) {
  throw UnimplementedError();
}

abstract class IAuthDataSource {
  const IAuthDataSource();

  Future<AuthUser> login();
  Future<AuthUser> loginWithToken();
  Future<void> logout();
}

class FakeAuthDataSource implements IAuthDataSource {
  static const _sharedPrefKey = 'token';
  static const _dummyUser = AuthUser(
    id: 'id',
    displayName: 'DummyUser',
    token: 'token',
  );

  Duration get _networkRoundTripTime {
    return Duration(milliseconds: Random().nextInt(500) + 500);
  }

  @override
  Future<AuthUser> login() async {
    final user = await Future.delayed(_networkRoundTripTime, () => _dummyUser);
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_sharedPrefKey, user.token);
    return user;
  }

  @override
  Future<AuthUser> loginWithToken() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString(_sharedPrefKey);
    if (token == null) throw AuthFailure('401 Unauthorized');
    return _dummyUser;
  }

  @override
  Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(_sharedPrefKey);
  }
}

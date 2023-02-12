import 'package:auth/src/models/auth_failure.dart';
import 'package:auth/src/models/auth_user.dart';
import 'package:auth/src/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthUser?> build() async {
    _authRefreshLogic();
    return _loginWithToken();
  }

  Future<void> login() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(),
    );
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async {
        await ref.read(authRepositoryProvider).logout();
        return null;
      },
    );
  }

  Future<AuthUser?> _loginWithToken() async {
    try {
      return ref.read(authRepositoryProvider).loginWithToken();
    } on AuthFailure {
      return null;
    }
  }

  void _authRefreshLogic() {
    ref.listenSelf((_, next) async {
      if (next.hasError) {
        state = await AsyncValue.guard(
          () async {
            await ref.read(authRepositoryProvider).logout();
            return null;
          },
        );
      }
    });
  }
}

import 'package:auth/auth.dart';
import 'package:employer/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_listenable.g.dart';

@riverpod
class RouterListenable extends _$RouterListenable implements Listenable {
  VoidCallback? _routerListener;
  bool _isAuth = false;

  @override
  FutureOr<void> build() async {
    _isAuth = await ref.watch(
      authControllerProvider.selectAsync((data) => data != null),
    );

    ref.listenSelf((_, __) {
      state.maybeWhen(
        orElse: () => _routerListener?.call(),
        loading: () => null,
      );
    });
  }

  String? redirect(BuildContext context, GoRouterState state) {
    if (this.state.isLoading || this.state.hasError) return null;

    final isSplash = state.location == SplashRoute().location;
    if (isSplash) return _isAuth ? HomeRoute().location : LoginRoute().location;

    final isLoggingIn = state.location == LoginRoute().location;
    if (isLoggingIn) return _isAuth ? HomeRoute().location : null;

    return _isAuth ? null : SplashRoute().location;
  }

  @override
  void addListener(VoidCallback listener) {
    _routerListener = listener;
  }

  @override
  void removeListener(VoidCallback listener) {
    _routerListener = null;
  }
}

import 'package:employer/app/router/router_listenable.dart';
import 'package:employer/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

// https://github.com/lucavenir/go_router_riverpod

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@riverpod
GoRouter router(RouterRef ref) {
  final listenable = ref.watch(routerListenableProvider.notifier);

  return GoRouter(
    navigatorKey: _key,
    refreshListenable: listenable,
    debugLogDiagnostics: true,
    initialLocation: SplashRoute().location,
    routes: $appRoutes,
    redirect: listenable.redirect,
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Failure implements Exception {
  Failure(this.message);
  final String message;
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension WidgetRefX on WidgetRef {
  void listenError<T>(ProviderListenable<AsyncValue<T>> provider) {
    listen(provider, (_, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          String? message;
          if (error is Failure) message = error.message;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text((message ?? error.toString()))),
            );
        },
      );
    });
  }
}

extension AsyncValueX<T> on AsyncValue<T> {
  Widget buildWhen({
    required Widget Function(T data) data,
    Widget Function(Object error, StackTrace stackTrace)? error,
    Widget Function()? loading,
    bool skipLoadingOnReload = false,
    bool skipLoadingOnRefresh = true,
    bool skipError = false,
  }) {
    return when(
      skipError: skipError,
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
      data: data,
      error: error ?? (e, _) => Center(child: Text(e.toString())),
      loading: loading ??
          () {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
    );
  }
}

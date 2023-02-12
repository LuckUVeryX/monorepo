import 'package:auth/auth.dart';
import 'package:candidate/app/app.dart';
import 'package:candidate/bootstrap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  bootstrap(
    () => ProviderScope(
      overrides: [
        authDataSourceProvider.overrideWithValue(FakeAuthDataSource())
      ],
      child: const App(),
    ),
  );
}

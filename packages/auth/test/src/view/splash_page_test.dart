import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('SplashPage', () {
    testWidgets('displays a CircularProgressIndicator', (tester) async {
      await tester.pumpApp(const SplashPage());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

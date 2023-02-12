import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/helpers.dart';

void main() {
  group('App', () {
    testWidgets('pumpApp works', (tester) async {
      await tester.pumpApp(const Placeholder());
      expect(find.byType(Placeholder), findsOneWidget);
    });
  });
}

import 'package:dogs_almanac/main.dart';
import 'package:dogs_almanac/pages/breeds_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('tap on the floating action button, verify counter',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(const DogsAlmanac());

      final cta = find.byKey(const Key('random_image_by_breed_cta'));

      await tester.tap(cta);

      await tester.pumpAndSettle();

      expect(find.byType(BreedsSearchPage), findsOneWidget);

      
    });
  });
}

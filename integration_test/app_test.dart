import 'package:dogs_almanac/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('Get random image of a breed',
        (tester) async {
      // Load app widget.
      await tester.pumpWidget(const DogsAlmanac());

      final cta = find.byKey(const Key('random_image_by_breed_cta'));

      await tester.tap(cta);

      await tester.pumpAndSettle();

      await tester.pumpAndSettle();

      final affenpinscherCard = find.byKey(const Key('affenpinscher_card'));

      await tester.tap(affenpinscherCard);

      await tester.pumpAndSettle();

      final affenpinscherImage = find.byKey(const Key('affenpinscher_image'));
      expect(affenpinscherImage, findsOneWidget);
    });
  });
}

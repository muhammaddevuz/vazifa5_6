import 'package:dars_5_3_getx/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("textfields and images", (widgetTester) async {
    await widgetTester.pumpWidget(MyApp());

    expect(find.byElementType(Image), findsNWidgets(4));
    expect(find.byType(GridView), findsNWidgets(2));
    expect(find.byType(Wrap), findsOneWidget);
  });
}

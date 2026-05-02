import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wolwoloom/wolwoloom.dart';

Widget _wrap(Widget child) => MaterialApp(
      theme: WlmTheme.light(),
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  testWidgets('WlmPrimaryButton renders label and triggers onPressed',
      (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _wrap(
        WlmPrimaryButton(
          label: 'Continue',
          onPressed: () => taps++,
        ),
      ),
    );
    expect(find.text('CONTINUE'), findsOneWidget);
    await tester.tap(find.byType(WlmPrimaryButton));
    expect(taps, 1);
  });

  testWidgets('WlmCheckbox toggles', (tester) async {
    var v = false;
    await tester.pumpWidget(
      _wrap(
        StatefulBuilder(
          builder: (ctx, setState) => WlmCheckbox(
            value: v,
            onChanged: (n) => setState(() => v = n),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(WlmCheckbox));
    await tester.pumpAndSettle();
    expect(v, isTrue);
  });

  testWidgets('WlmSegmentedControl reports selection', (tester) async {
    var v = 'a';
    await tester.pumpWidget(
      _wrap(
        StatefulBuilder(
          builder: (ctx, setState) => WlmSegmentedControl<String>(
            value: v,
            onChanged: (n) => setState(() => v = n),
            segments: const [
              WlmSegment(value: 'a', label: 'A'),
              WlmSegment(value: 'b', label: 'B'),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('B'));
    await tester.pumpAndSettle();
    expect(v, 'b');
  });

  testWidgets('WlmStat renders label and value', (tester) async {
    await tester.pumpWidget(
      _wrap(
        const WlmStat(
          label: 'Downloads',
          value: '1,204',
          trend: '+5%',
          trendPositive: true,
        ),
      ),
    );
    expect(find.text('DOWNLOADS'), findsOneWidget);
    expect(find.text('1,204'), findsOneWidget);
    expect(find.text('+5%'), findsOneWidget);
  });

  testWidgets('WlmTabBar swaps active tab', (tester) async {
    var i = 0;
    await tester.pumpWidget(
      _wrap(
        StatefulBuilder(
          builder: (ctx, setState) => WlmTabBar(
            currentIndex: i,
            onTap: (n) => setState(() => i = n),
            tabs: const [WlmTab(label: 'One'), WlmTab(label: 'Two')],
          ),
        ),
      ),
    );
    await tester.tap(find.text('TWO'));
    await tester.pumpAndSettle();
    expect(i, 1);
  });
}

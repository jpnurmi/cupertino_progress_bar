// Copyright 2020 J-P Nurmi <jpnurmi@gmail.com>
//
// Based on flutter/test/material/progress_indicator_test.dart
//
// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:cupertino_progress_bar/cupertino_progress_bar.dart';

import 'third_party/mock_canvas.dart';

void main() {
  // The "can be constructed" tests that follow are primarily to ensure that any
  // animations started by the progress indicators are stopped at dispose() time.

  testWidgets(
      'CupertinoProgressBar(value: 0.0) can be constructed and has empty semantics by default',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200.0,
            child: CupertinoProgressBar(value: 0.0),
          ),
        ),
      ),
    );

    expect(tester.getSemantics(find.byType(CupertinoProgressBar)),
        matchesSemantics());
    handle.dispose();
  });

  testWidgets('CupertinoProgressBar paint (LTR)', (WidgetTester tester) async {
    final CupertinoThemeData theme = CupertinoThemeData();
    await tester.pumpWidget(
      CupertinoTheme(
        data: theme,
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 200.0,
              child: CupertinoProgressBar(value: 0.25),
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 0, 50, 2, Radius.circular(1)),
            color: Color(theme.primaryColor.value))
        ..rrect(
            rrect: RRect.fromLTRBR(50, 0, 200, 2, Radius.circular(1)),
            color: Color(CupertinoColors.systemFill.value)),
    );

    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('CupertinoProgressBar paint (RTL)', (WidgetTester tester) async {
    final CupertinoThemeData theme = CupertinoThemeData();
    await tester.pumpWidget(
      CupertinoTheme(
        data: theme,
        child: const Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: SizedBox(
              width: 200.0,
              child: CupertinoProgressBar(value: 0.25),
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 0, 150, 2, Radius.circular(1)),
            color: Color(CupertinoColors.systemFill.value))
        ..rrect(
            rrect: RRect.fromLTRBR(150, 0, 200, 2, Radius.circular(1)),
            color: Color(theme.primaryColor.value)),
    );

    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('CupertinoProgressBar with colors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 200.0,
            child: CupertinoProgressBar(
              value: 0.25,
              valueColor: CupertinoColors.white,
              trackColor: CupertinoColors.black,
            ),
          ),
        ),
      ),
    );

    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 0, 50, 2, Radius.circular(1)),
            color: CupertinoColors.white)
        ..rrect(
            rrect: RRect.fromLTRBR(50, 0, 200, 2, Radius.circular(1)),
            color: CupertinoColors.black),
    );
  });

  testWidgets('CupertinoProgressBar causes a repaint when it changes',
      (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child:
          ListView(children: const <Widget>[CupertinoProgressBar(value: 0.0)]),
    ));
    final List<Layer> layers1 = tester.layers;
    await tester.pumpWidget(
      Directionality(
          textDirection: TextDirection.ltr,
          child: ListView(
              children: const <Widget>[CupertinoProgressBar(value: 0.5)])),
    );
    final List<Layer> layers2 = tester.layers;
    expect(layers1, isNot(equals(layers2)));
  });

  testWidgets('CupertinoProgressBar with large height',
      (WidgetTester tester) async {
    final CupertinoThemeData theme = CupertinoThemeData();
    await tester.pumpWidget(
      CupertinoTheme(
        data: theme,
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 100.0,
              height: 10.0,
              child: CupertinoProgressBar(value: 0.25),
            ),
          ),
        ),
      ),
    );
    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 4, 25, 6, Radius.circular(1)),
            color: Color(theme.primaryColor.value))
        ..rrect(
            rrect: RRect.fromLTRBR(25, 4, 100, 6, Radius.circular(1)),
            color: Color(CupertinoColors.systemFill.value)),
    );
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('CupertinoProgressBar with tiny height',
      (WidgetTester tester) async {
    final CupertinoThemeData theme = CupertinoThemeData();
    await tester.pumpWidget(
      CupertinoTheme(
        data: theme,
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 100.0,
              height: 1.0,
              child: CupertinoProgressBar(value: 0.25),
            ),
          ),
        ),
      ),
    );
    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 0, 25, 1, Radius.circular(1)),
            color: Color(theme.primaryColor.value))
        ..rrect(
            rrect: RRect.fromLTRBR(25, 0, 100, 1, Radius.circular(1)),
            color: Color(CupertinoColors.systemFill.value)),
    );
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('CupertinoProgressBar with default height',
      (WidgetTester tester) async {
    final CupertinoThemeData theme = CupertinoThemeData();
    await tester.pumpWidget(
      CupertinoTheme(
        data: theme,
        child: const Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 100.0,
              height: 2.0,
              child: CupertinoProgressBar(value: 0.25),
            ),
          ),
        ),
      ),
    );
    expect(
      find.byType(CupertinoProgressBar),
      paints
        ..rrect(
            rrect: RRect.fromLTRBR(0, 0, 25, 2, Radius.circular(1)),
            color: Color(theme.primaryColor.value))
        ..rrect(
            rrect: RRect.fromLTRBR(25, 0, 100, 2, Radius.circular(1)),
            color: Color(CupertinoColors.systemFill.value)),
    );
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('CupertinoProgressBar can be made accessible',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final GlobalKey key = GlobalKey();
    const String label = 'Label';
    const String value = '25%';
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoProgressBar(
          key: key,
          value: 0.25,
          semanticsLabel: label,
          semanticsValue: value,
        ),
      ),
    );

    expect(
        tester.getSemantics(find.byKey(key)),
        matchesSemantics(
          textDirection: TextDirection.ltr,
          label: label,
          value: value,
        ));

    handle.dispose();
  });

  testWidgets(
      'CupertinoProgressBar that is determinate gets default a11y value',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final GlobalKey key = GlobalKey();
    const String label = 'Label';
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoProgressBar(
          key: key,
          value: 0.25,
          semanticsLabel: label,
        ),
      ),
    );

    expect(
        tester.getSemantics(find.byKey(key)),
        matchesSemantics(
          textDirection: TextDirection.ltr,
          label: label,
          value: '25%',
        ));

    handle.dispose();
  });

  testWidgets(
      'CupertinoProgressBar that is determinate does not default a11y value when label is null',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final GlobalKey key = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoProgressBar(
          key: key,
          value: 0.25,
        ),
      ),
    );

    expect(tester.getSemantics(find.byKey(key)), matchesSemantics());

    handle.dispose();
  });

  testWidgets(
      'CupertinoProgressBar that is indeterminate does not default a11y value',
      (WidgetTester tester) async {
    final SemanticsHandle handle = tester.ensureSemantics();
    final GlobalKey key = GlobalKey();
    const String label = 'Progress';
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: CupertinoProgressBar(
          key: key,
          value: 0.25,
          semanticsLabel: label,
        ),
      ),
    );

    expect(
        tester.getSemantics(find.byKey(key)),
        matchesSemantics(
          textDirection: TextDirection.ltr,
          label: label,
        ));

    handle.dispose();
  });
}

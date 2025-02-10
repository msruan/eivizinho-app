// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:eiviznho/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'mocks.dart';

testApp(
  WidgetTester tester,
  Widget body, {
  GoRouter? goRouter,
}) async {
  tester.view.devicePixelRatio = 1.0;
  await tester.binding.setSurfaceSize(const Size(1200, 800));
  await tester.pumpWidget(
    MaterialApp(
      theme: App.theme,
      home: InheritedGoRouter(
        goRouter: goRouter ?? MockGoRouter(),
        child: Scaffold(
          body: body,
        ),
      ),
    ),
  );
}

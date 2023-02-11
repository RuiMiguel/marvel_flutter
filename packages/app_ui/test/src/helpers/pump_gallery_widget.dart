// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpGalleryWidget(
    Widget widget,
  ) async {
    await pumpWidget(
      MaterialApp(
        home: widget,
      ),
    );

    await pump();
  }
}

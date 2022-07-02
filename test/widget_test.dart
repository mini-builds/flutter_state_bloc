import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_bloc/state/log_in_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_state_bloc/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([LogInCubit])
void main() {
  var bloc = MockLogInCubit();

  testWidgets('Log in button is enabled while not logging in', (WidgetTester tester) async {
    when(bloc.state).thenReturn(const LogInState(false, false));
    when(bloc.stream).thenAnswer((_) => Stream.fromIterable([const LogInState(false, false)]));

    await tester.pumpWidget(BlocProvider<LogInCubit>(
      create: (context) => bloc,
      child: const StateExample(),
    ));

    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isTrue);
  });

  testWidgets('Log in button is disabled while logging in', (WidgetTester tester) async {
    when(bloc.state).thenReturn(const LogInState(false, true));
    when(bloc.stream).thenAnswer((_) => Stream.fromIterable([const LogInState(false, true)]));

    await tester.pumpWidget(BlocProvider<LogInCubit>(
      create: (context) => bloc,
      child: const StateExample(),
    ));

    expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, isFalse);
  });

  testWidgets('Clicking the log in button calls bloc.logIn(...)', (WidgetTester tester) async {
    when(bloc.state).thenReturn(const LogInState(false, false));
    when(bloc.stream).thenAnswer((_) => Stream.fromIterable([const LogInState(false, false)]));

    await tester.pumpWidget(BlocProvider<LogInCubit>(
      create: (context) => bloc,
      child: const StateExample(),
    ));

    tester.widget<TextField>(find.byType(TextField).first).controller?.text = "a-username";
    tester.widget<TextField>(find.byType(TextField).last).controller?.text = "a-password";

    await tester.tap(find.byType(ElevatedButton));

    verify(bloc.logIn("a-username", "a-password"));
  });

}

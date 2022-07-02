import 'package:flutter_state_bloc/state/log_in_cubit.dart';
import 'package:bloc_test/bloc_test.dart';


class MockLogInCubit extends MockCubit<LogInState> implements LogInCubit {}

void main() {
  blocTest<LogInCubit, LogInState>(
    'emits logging in state and then logged in state when logIn is called',
    build: () => LogInCubit(),
    act: (bloc) => bloc.logIn("test@test.com", "password"),
    expect: () => const [LogInState(false, true), LogInState(true, false)],
  );
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class LogInState extends Equatable {
  final bool isLoggedIn;
  final bool isLoggingIn;

  const LogInState(this.isLoggedIn, this.isLoggingIn);

  @override
  List<Object> get props => [isLoggedIn, isLoggingIn];
}

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(const LogInState(false, false));

  void logIn(String username, String password) async {
    emit(const LogInState(false, true));

    // simulate api call with a delay
    await Future.delayed(const Duration(seconds: 2));

    emit(const LogInState(true, false));
  }
}

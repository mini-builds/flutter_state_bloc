import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_state_bloc/state/log_in_cubit.dart';

void main() {
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<LogInCubit>(create: (context) => LogInCubit()),
    ], child: const StateExample()),
  );
}

class StateExample extends StatelessWidget {
  const StateExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LogInPage(),
    );
  }
}

class LogInPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<LogInCubit, LogInState>(builder: (context, state) {
          if (state.isLoggedIn) {
            return const Text("Logged in!");
          }

          return Column(
            children: [
              TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: 'Username')),
              const SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: state.isLoggingIn
                    ? null
                    : () {
                        context
                            .read<LogInCubit>()
                            .logIn(_usernameController.text, _passwordController.text);
                      },
              ),
            ],
          );
        }),
      ),
    );
  }
}

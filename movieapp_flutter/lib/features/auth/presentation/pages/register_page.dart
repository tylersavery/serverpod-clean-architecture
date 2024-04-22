import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/core/utils/show_snackbar.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/register_confirmation_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_list_page.dart';

class RegisterPage extends StatefulWidget {
  static String route() => "/register";

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateFailure) {
              showSnackbar(context, state.message);
            } else if (state is AuthStateConfirmationRequired) {
              context.go(RegisterConfirmationPage.route());
            } else if (state is AuthStateSuccess) {
              context.go(MovieListPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Loader();
            }

            if (state is AuthStateSuccess || state is AuthStateConfirmationRequired) {
              return const SizedBox();
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthRegisterEvent(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                                username: usernameController.text.trim(),
                              ),
                            );
                      }
                    },
                    child: const Text("Register"),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.go(LoginPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.pink),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/core/utils/show_snackbar.dart';
import 'package:movieapp_flutter/core/widgets/loader.dart';
import 'package:movieapp_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_list_page.dart';

class LoginPage extends StatefulWidget {
  static String route() => "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController(text: 'test@tylersavery.com');
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateFailure) {
              showSnackbar(context, state.message);
            }

            if (state is AuthStateSuccess) {
              context.go(MovieListPage.route());
            }
          },
          builder: (context, state) {
            if (state is AuthStateLoading) {
              return const Loader();
            }

            if (state is AuthStateSuccess) {
              return const SizedBox.shrink();
            }

            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email Required";
                      }

                      // TODO validate email
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Password Required";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthLoginEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      child: const Text("Login")),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      context.go(RegisterPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink,
                                ),
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

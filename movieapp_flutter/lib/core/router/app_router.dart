import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movieapp_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/register_confirmation_page.dart';
import 'package:movieapp_flutter/features/auth/presentation/pages/register_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_detail_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_edit_page.dart';
import 'package:movieapp_flutter/features/movie/presentation/pages/movie_list_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: LoginPage.route(),
    routes: [
      GoRoute(
        path: LoginPage.route(),
        builder: (context, _) => const LoginPage(),
      ),
      GoRoute(
        path: RegisterPage.route(),
        builder: (context, _) => const RegisterPage(),
      ),
      GoRoute(
        path: RegisterConfirmationPage.route(),
        builder: (context, _) => const RegisterConfirmationPage(),
      ),
      GoRoute(
        path: MovieListPage.route(),
        builder: (context, _) => const MovieListPage(),
      ),
      GoRoute(
        path: MovieEditPage.routeNew(),
        builder: (context, _) => const MovieEditPage(),
      ),
      GoRoute(
        path: MovieEditPage.route(),
        builder: (context, state) => MovieEditPage(
          movieId: int.parse(state.pathParameters['id'] ?? '0'),
        ),
      ),
      GoRoute(
        path: MovieDetailPage.route(),
        builder: (context, state) => MovieDetailPage(
          movieId: int.parse(
            state.pathParameters['id'] ?? '0',
          ),
        ),
      ),
    ],
    redirect: (context, state) {
      final userState = context.read<AppUserCubit>().state;

      final publicRoutes = [
        LoginPage.route(),
        RegisterPage.route(),
        RegisterConfirmationPage.route(),
      ];

      if (!publicRoutes.contains(state.matchedLocation)) {
        if (userState is AppUserInitial) {
          return LoginPage.route();
        }
      }

      return null;
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:movieapp_flutter/core/router/app_router.dart';
import 'package:movieapp_flutter/dependencies.dart';
import 'package:movieapp_flutter/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:movieapp_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_manage/movie_manage_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>()..add(AuthIsUserLoggedInEvent()),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MovieListBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<MovieManageBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AssetBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppUserCubit, AppUserState>(
      listener: (context, state) {
        AppRouter.router.refresh();
      },
      child: MaterialApp.router(
        title: "Clean Serverpod",
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}

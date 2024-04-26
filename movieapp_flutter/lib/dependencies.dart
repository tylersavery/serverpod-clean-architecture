import 'package:get_it/get_it.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/features/app_user/presentation/cubits/cubit/app_user_cubit.dart';
import 'package:movieapp_flutter/features/asset/data/datasources/asset_data_source.dart';
import 'package:movieapp_flutter/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:movieapp_flutter/features/asset/domain/repositories/asset_repository.dart';
import 'package:movieapp_flutter/features/asset/domain/usecases/upload_image.dart';
import 'package:movieapp_flutter/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:movieapp_flutter/features/auth/data/datasources/auth_datasource.dart';
import 'package:movieapp_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:movieapp_flutter/features/auth/domain/respositories/auth_repository.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/current_user.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_confirm_registration.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_login.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_logout.dart';
import 'package:movieapp_flutter/features/auth/domain/usecases/user_register.dart';
import 'package:movieapp_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movieapp_flutter/features/movie/data/datasources/movie_datasource.dart';
import 'package:movieapp_flutter/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/delete_movie.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/list_movies.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/retrieve_movie.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/save_movie.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_manage/movie_manage_bloc.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton<Client>(
    () => Client(
      "http://localhost:8080/",
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor(),
  );

  serviceLocator.registerLazySingleton<SessionManager>(
    () => SessionManager(
      caller: serviceLocator<Client>().modules.auth,
    ),
  );

  await serviceLocator<SessionManager>().initialize();

  _initAuth();
  _initMovie();
  _initAsset();
}

void _initAuth() {
  // Data Source
  serviceLocator.registerFactory<AuthDataSource>(
    () => AuthDataSourceImpl(
      serviceLocator<Client>(),
      serviceLocator<SessionManager>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator<AuthDataSource>(),
    ),
  );

  // Use Cases

  serviceLocator.registerFactory<CurrentUserUseCase>(
    () => CurrentUserUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<UserLoginUseCase>(
    () => UserLoginUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<UserRegisterUseCase>(
    () => UserRegisterUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<UserConfirmRegistrationUseCase>(
    () => UserConfirmRegistrationUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  serviceLocator.registerFactory<UserLogoutUseCase>(
    () => UserLogoutUseCase(
      serviceLocator<AuthRepository>(),
    ),
  );

  // Bloc

  serviceLocator.registerLazySingleton<AuthBloc>(
    () => AuthBloc(
      appUserCubit: serviceLocator<AppUserCubit>(),
      userLogin: serviceLocator<UserLoginUseCase>(),
      currentUser: serviceLocator<CurrentUserUseCase>(),
      userLogout: serviceLocator<UserLogoutUseCase>(),
      userRegister: serviceLocator<UserRegisterUseCase>(),
      userConfirmRegistration: serviceLocator<UserConfirmRegistrationUseCase>(),
    ),
  );
}

void _initMovie() {
  // Data Source
  serviceLocator.registerFactory<MovieDatasource>(
    () => MovieDatasourceImpl(
      serviceLocator<Client>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<MovieRepository>(
    () => MovieRepositoryImpl(
      serviceLocator<MovieDatasource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerFactory<ListMoviesUseCase>(
    () => ListMoviesUseCase(
      serviceLocator<MovieRepository>(),
    ),
  );

  serviceLocator.registerFactory<RetrieveMovieUseCase>(
    () => RetrieveMovieUseCase(
      serviceLocator<MovieRepository>(),
    ),
  );

  serviceLocator.registerFactory<SaveMovieUseCase>(
    () => SaveMovieUseCase(
      serviceLocator<MovieRepository>(),
    ),
  );

  serviceLocator.registerFactory<DeleteMovieUseCase>(
    () => DeleteMovieUseCase(
      serviceLocator<MovieRepository>(),
    ),
  );

  // Blocs

  serviceLocator.registerLazySingleton(
    () => MovieListBloc(
      listMovies: serviceLocator<ListMoviesUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => MovieDetailBloc(
      retrieveMovie: serviceLocator<RetrieveMovieUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => MovieManageBloc(
      retrieveMovie: serviceLocator<RetrieveMovieUseCase>(),
      saveMovie: serviceLocator<SaveMovieUseCase>(),
      deleteMovie: serviceLocator<DeleteMovieUseCase>(),
    ),
  );
}

void _initAsset() {
// Data Source
  serviceLocator.registerFactory<AssetDataSource>(
    () => AssetDataSourceImpl(
      serviceLocator<Client>(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<AssetRepository>(
    () => AssetRepositoryImpl(
      serviceLocator<AssetDataSource>(),
    ),
  );

  // Use Case
  serviceLocator.registerFactory<UploadImageUseCase>(
    () => UploadImageUseCase(
      serviceLocator<AssetRepository>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AssetBloc(
      uploadImage: serviceLocator<UploadImageUseCase>(),
    ),
  );
}

import 'package:get_it/get_it.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/features/movie/data/datasources/movie_datasource.dart';
import 'package:movieapp_flutter/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/list_movies.dart';
import 'package:movieapp_flutter/features/movie/domain/usecases/retrieve_movie.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_list/movie_list_bloc.dart';
import 'package:movieapp_flutter/features/movie/presentation/bloc/movie_retrieve/movie_retrieve_bloc.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  serviceLocator.registerLazySingleton<Client>(
    () => Client("http://localhost:8080/")..connectivityMonitor = FlutterConnectivityMonitor(),
  );

  _initMovie();
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

  // Blocs

  serviceLocator.registerLazySingleton(
    () => MovieListBloc(
      listMovies: serviceLocator<ListMoviesUseCase>(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => MovieRetrieveBloc(
      retrieveMovie: serviceLocator<RetrieveMovieUseCase>(),
    ),
  );
}

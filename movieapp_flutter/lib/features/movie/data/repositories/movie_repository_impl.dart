import 'package:fpdart/fpdart.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/features/movie/data/datasources/movie_datasource.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Movie>>> list() async {
    try {
      return right(await datasource.list());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Movie>> retrieve(int id) async {
    try {
      return right(await datasource.retrieve(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Movie>> save(Movie movie) async {
    try {
      return right(await datasource.save(movie));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> delete(int id) async {
    try {
      return right(await datasource.delete(id));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';

abstract interface class MovieDatasource {
  Future<List<Movie>> list();
  Future<Movie> retrieve(int id);
  Future<Movie> save(Movie movie);
  Future<void> delete(int id);
}

class MovieDatasourceImpl implements MovieDatasource {
  final Client client;
  // final SessionManager sessionManager;

  MovieDatasourceImpl(this.client);

  @override
  Future<List<Movie>> list() async {
    try {
      return await client.movie.list();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Movie> retrieve(int id) async {
    print(id);
    try {
      final result = await client.movie.retrieve(id);
      if (result == null) {
        throw const ServerException("Movie not found");
      }
      return result;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Movie> save(Movie movie) async {
    try {
      return await client.movie.save(movie);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> delete(int id) async {
    try {
      await client.movie.delete(id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

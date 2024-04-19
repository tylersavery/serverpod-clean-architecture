import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/exceptions.dart';

abstract interface class MovieDatasource {
  Future<List<Movie>> list();
  Future<Movie> retrieve(int id);
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
}

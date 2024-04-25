import 'package:movieapp_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

class MovieEndpoint extends Endpoint {
  Future<List<Movie>> list(Session session) async {
    return Movie.db.find(session);
  }

  Future<Movie?> retrieve(Session session, int id) async {
    return Movie.db.findById(session, id);
  }

  Future<Movie> save(Session session, Movie movie) async {
    return await (movie.id != null ? Movie.db.updateRow(session, movie) : Movie.db.insertRow(session, movie));
  }

  Future<void> delete(Session session, int id) async {
    await Movie.db.deleteWhere(session, where: (row) => row.id.equals(id));
  }
}

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Movie extends _i1.TableRow {
  Movie._({
    int? id,
    required this.title,
    required this.year,
    required this.imageUrl,
    required this.logline,
    required this.directorName,
  }) : super(id);

  factory Movie({
    int? id,
    required String title,
    required int year,
    required String imageUrl,
    required String logline,
    required String directorName,
  }) = _MovieImpl;

  factory Movie.fromJson(
    Map<String, dynamic> jsonSerialization,
    _i1.SerializationManager serializationManager,
  ) {
    return Movie(
      id: serializationManager.deserialize<int?>(jsonSerialization['id']),
      title:
          serializationManager.deserialize<String>(jsonSerialization['title']),
      year: serializationManager.deserialize<int>(jsonSerialization['year']),
      imageUrl: serializationManager
          .deserialize<String>(jsonSerialization['imageUrl']),
      logline: serializationManager
          .deserialize<String>(jsonSerialization['logline']),
      directorName: serializationManager
          .deserialize<String>(jsonSerialization['directorName']),
    );
  }

  static final t = MovieTable();

  static const db = MovieRepository._();

  String title;

  int year;

  String imageUrl;

  String logline;

  String directorName;

  @override
  _i1.Table get table => t;

  Movie copyWith({
    int? id,
    String? title,
    int? year,
    String? imageUrl,
    String? logline,
    String? directorName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'year': year,
      'imageUrl': imageUrl,
      'logline': logline,
      'directorName': directorName,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  Map<String, dynamic> toJsonForDatabase() {
    return {
      'id': id,
      'title': title,
      'year': year,
      'imageUrl': imageUrl,
      'logline': logline,
      'directorName': directorName,
    };
  }

  @override
  Map<String, dynamic> allToJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'year': year,
      'imageUrl': imageUrl,
      'logline': logline,
      'directorName': directorName,
    };
  }

  @override
  @Deprecated('Will be removed in 2.0.0')
  void setColumn(
    String columnName,
    value,
  ) {
    switch (columnName) {
      case 'id':
        id = value;
        return;
      case 'title':
        title = value;
        return;
      case 'year':
        year = value;
        return;
      case 'imageUrl':
        imageUrl = value;
        return;
      case 'logline':
        logline = value;
        return;
      case 'directorName':
        directorName = value;
        return;
      default:
        throw UnimplementedError();
    }
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.find instead.')
  static Future<List<Movie>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? limit,
    int? offset,
    _i1.Column? orderBy,
    List<_i1.Order>? orderByList,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Movie>(
      where: where != null ? where(Movie.t) : null,
      limit: limit,
      offset: offset,
      orderBy: orderBy,
      orderByList: orderByList,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findRow instead.')
  static Future<Movie?> findSingleRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? offset,
    _i1.Column? orderBy,
    bool orderDescending = false,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findSingleRow<Movie>(
      where: where != null ? where(Movie.t) : null,
      offset: offset,
      orderBy: orderBy,
      orderDescending: orderDescending,
      useCache: useCache,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.findById instead.')
  static Future<Movie?> findById(
    _i1.Session session,
    int id,
  ) async {
    return session.db.findById<Movie>(id);
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteWhere instead.')
  static Future<int> delete(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MovieTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Movie>(
      where: where(Movie.t),
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.deleteRow instead.')
  static Future<bool> deleteRow(
    _i1.Session session,
    Movie row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.update instead.')
  static Future<bool> update(
    _i1.Session session,
    Movie row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.update(
      row,
      transaction: transaction,
    );
  }

  @Deprecated(
      'Will be removed in 2.0.0. Use: db.insert instead. Important note: In db.insert, the object you pass in is no longer modified, instead a new copy with the added row is returned which contains the inserted id.')
  static Future<void> insert(
    _i1.Session session,
    Movie row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert(
      row,
      transaction: transaction,
    );
  }

  @Deprecated('Will be removed in 2.0.0. Use: db.count instead.')
  static Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? limit,
    bool useCache = true,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Movie>(
      where: where != null ? where(Movie.t) : null,
      limit: limit,
      useCache: useCache,
      transaction: transaction,
    );
  }

  static MovieInclude include() {
    return MovieInclude._();
  }

  static MovieIncludeList includeList({
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MovieTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MovieTable>? orderByList,
    MovieInclude? include,
  }) {
    return MovieIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Movie.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Movie.t),
      include: include,
    );
  }
}

class _Undefined {}

class _MovieImpl extends Movie {
  _MovieImpl({
    int? id,
    required String title,
    required int year,
    required String imageUrl,
    required String logline,
    required String directorName,
  }) : super._(
          id: id,
          title: title,
          year: year,
          imageUrl: imageUrl,
          logline: logline,
          directorName: directorName,
        );

  @override
  Movie copyWith({
    Object? id = _Undefined,
    String? title,
    int? year,
    String? imageUrl,
    String? logline,
    String? directorName,
  }) {
    return Movie(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      year: year ?? this.year,
      imageUrl: imageUrl ?? this.imageUrl,
      logline: logline ?? this.logline,
      directorName: directorName ?? this.directorName,
    );
  }
}

class MovieTable extends _i1.Table {
  MovieTable({super.tableRelation}) : super(tableName: 'movie') {
    title = _i1.ColumnString(
      'title',
      this,
    );
    year = _i1.ColumnInt(
      'year',
      this,
    );
    imageUrl = _i1.ColumnString(
      'imageUrl',
      this,
    );
    logline = _i1.ColumnString(
      'logline',
      this,
    );
    directorName = _i1.ColumnString(
      'directorName',
      this,
    );
  }

  late final _i1.ColumnString title;

  late final _i1.ColumnInt year;

  late final _i1.ColumnString imageUrl;

  late final _i1.ColumnString logline;

  late final _i1.ColumnString directorName;

  @override
  List<_i1.Column> get columns => [
        id,
        title,
        year,
        imageUrl,
        logline,
        directorName,
      ];
}

@Deprecated('Use MovieTable.t instead.')
MovieTable tMovie = MovieTable();

class MovieInclude extends _i1.IncludeObject {
  MovieInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Movie.t;
}

class MovieIncludeList extends _i1.IncludeList {
  MovieIncludeList._({
    _i1.WhereExpressionBuilder<MovieTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Movie.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Movie.t;
}

class MovieRepository {
  const MovieRepository._();

  Future<List<Movie>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MovieTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MovieTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.find<Movie>(
      where: where?.call(Movie.t),
      orderBy: orderBy?.call(Movie.t),
      orderByList: orderByList?.call(Movie.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Movie?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? offset,
    _i1.OrderByBuilder<MovieTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MovieTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findFirstRow<Movie>(
      where: where?.call(Movie.t),
      orderBy: orderBy?.call(Movie.t),
      orderByList: orderByList?.call(Movie.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Movie?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.findById<Movie>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Movie>> insert(
    _i1.Session session,
    List<Movie> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insert<Movie>(
      rows,
      transaction: transaction,
    );
  }

  Future<Movie> insertRow(
    _i1.Session session,
    Movie row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.insertRow<Movie>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Movie>> update(
    _i1.Session session,
    List<Movie> rows, {
    _i1.ColumnSelections<MovieTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.update<Movie>(
      rows,
      columns: columns?.call(Movie.t),
      transaction: transaction,
    );
  }

  Future<Movie> updateRow(
    _i1.Session session,
    Movie row, {
    _i1.ColumnSelections<MovieTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.updateRow<Movie>(
      row,
      columns: columns?.call(Movie.t),
      transaction: transaction,
    );
  }

  Future<List<int>> delete(
    _i1.Session session,
    List<Movie> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.delete<Movie>(
      rows,
      transaction: transaction,
    );
  }

  Future<int> deleteRow(
    _i1.Session session,
    Movie row, {
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteRow<Movie>(
      row,
      transaction: transaction,
    );
  }

  Future<List<int>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<MovieTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.deleteWhere<Movie>(
      where: where(Movie.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<MovieTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.dbNext.count<Movie>(
      where: where?.call(Movie.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

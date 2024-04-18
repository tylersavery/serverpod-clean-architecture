/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Movie extends _i1.SerializableEntity {
  Movie._({
    this.id,
    required this.title,
    required this.year,
    required this.imageUrl,
    required this.logline,
    required this.directorName,
  });

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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  int year;

  String imageUrl;

  String logline;

  String directorName;

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

/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports
// ignore_for_file: use_super_parameters
// ignore_for_file: type_literal_in_constant_pattern

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:movieapp_client/src/protocol/movie.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointMovie extends _i1.EndpointRef {
  EndpointMovie(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'movie';

  _i2.Future<List<_i3.Movie>> list() =>
      caller.callServerEndpoint<List<_i3.Movie>>(
        'movie',
        'list',
        {},
      );

  _i2.Future<_i3.Movie> create(_i3.Movie movie) =>
      caller.callServerEndpoint<_i3.Movie>(
        'movie',
        'create',
        {'movie': movie},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
        ) {
    example = EndpointExample(this);
    movie = EndpointMovie(this);
  }

  late final EndpointExample example;

  late final EndpointMovie movie;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'movie': movie,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}

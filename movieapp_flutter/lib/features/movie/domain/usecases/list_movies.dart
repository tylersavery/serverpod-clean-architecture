import 'package:fpdart/fpdart.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';

class ListMoviesUseCase implements UseCase<List<Movie>, NoParams> {
  final MovieRepository movieRepository;

  const ListMoviesUseCase(this.movieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await movieRepository.list();
  }
}

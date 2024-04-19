import 'package:fpdart/fpdart.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';

class RetrieveMovieUseCase implements UseCase<Movie, RetrieveMovieParams> {
  final MovieRepository movieRepository;

  const RetrieveMovieUseCase(this.movieRepository);

  @override
  Future<Either<Failure, Movie>> call(RetrieveMovieParams params) async {
    return await movieRepository.retrieve(params.id);
  }
}

class RetrieveMovieParams {
  final int id;
  const RetrieveMovieParams({required this.id});
}

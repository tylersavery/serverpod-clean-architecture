import 'package:fpdart/fpdart.dart';
import 'package:movieapp_client/movieapp_client.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';

class SaveMovieUseCase implements UseCase<Movie, SaveMovieParams> {
  final MovieRepository movieRepository;

  const SaveMovieUseCase(this.movieRepository);

  @override
  Future<Either<Failure, Movie>> call(SaveMovieParams params) async {
    return await movieRepository.save(params.movie);
  }
}

class SaveMovieParams {
  final Movie movie;
  const SaveMovieParams({required this.movie});
}

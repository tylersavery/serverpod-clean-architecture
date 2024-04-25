import 'package:fpdart/fpdart.dart';
import 'package:movieapp_flutter/core/error/failure.dart';
import 'package:movieapp_flutter/core/usecases/usecase.dart';
import 'package:movieapp_flutter/features/movie/domain/repositories/movie_repository.dart';

class DeleteMovieUseCase implements UseCase<void, DeleteMovieParams> {
  final MovieRepository movieRepository;

  const DeleteMovieUseCase(this.movieRepository);

  @override
  Future<Either<Failure, void>> call(DeleteMovieParams params) async {
    return await movieRepository.delete(params.id);
  }
}

class DeleteMovieParams {
  final int id;
  const DeleteMovieParams({required this.id});
}

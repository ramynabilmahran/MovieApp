import 'package:dartz/dartz.dart';
import 'package:netflix/core/error/failure.dart';
import 'package:netflix/core/usecase/base_usecase.dart';
import 'package:netflix/movies/domain/entities/movie.dart';
import 'package:netflix/movies/domain/repository/base_movies_repository.dart';

class GetPopularMoviesUseCase extends BaseUseCase<List<Movie>,NoParameters>{
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameters parameters) async {
    return await baseMoviesRepository.getPopularMovies();
  }
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/core/error/failure.dart';
import 'package:netflix/core/usecase/base_usecase.dart';
import 'package:netflix/movies/domain/entities/recommendation.dart';
import 'package:netflix/movies/domain/repository/base_movies_repository.dart';

class GetRecommendationUseCase
    extends BaseUseCase<List<Recommendation>, RecommendationParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetRecommendationUseCase(this.baseMoviesRepository);
  @override
  Future<Either<Failure, List<Recommendation>>> call(parameters) async {
    return await baseMoviesRepository.getRecommendation(parameters);
  }
}

class RecommendationParameters extends Equatable {
  final int id;

  const RecommendationParameters(this.id);

  @override
  List<Object?> get props => [id];
}

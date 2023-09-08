import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:netflix/core/utils/enums.dart';
import 'package:netflix/movies/domain/entities/movie_detail.dart';
import 'package:netflix/movies/domain/entities/recommendation.dart';
import 'package:netflix/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:netflix/movies/domain/usecases/get_recommendation_usecase.dart';

part 'movie_details_event.dart';
part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc(this.getMovieDetailsUseCase, this.getRecommendationUseCase)
      : super(const MovieDetailsState()) {
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<GetRecommendationEvent>(_getRecommendation);
  }
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationUseCase getRecommendationUseCase;

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieDetailsUseCase(MovieDetailsParameters(movieId: event.id));

    result.fold(
        (l) => emit(state.copyWith(
            movieDetailsState: RequestState.error,
            movieDetailsmessage: l.message)),
        (r) => emit(state.copyWith(
            movieDetail: r, movieDetailsState: RequestState.loaded)));
  }

  FutureOr<void> _getRecommendation(
      GetRecommendationEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getRecommendationUseCase(RecommendationParameters(event.id));

    result.fold(
        (l) => emit(state.copyWith(
            recommendationState: RequestState.error,
            recommendationMessage: l.message)),
        (r) => emit(state.copyWith(
              recommendation: r,
              recommendationState: RequestState.loaded,
            )));
  }
}

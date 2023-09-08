import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:netflix/core/usecase/base_usecase.dart';
import 'package:netflix/core/utils/enums.dart';
import 'package:netflix/movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:netflix/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:netflix/movies/presentation/controller/moies_state.dart';
import 'package:netflix/movies/presentation/controller/movies_event.dart';
import 'package:netflix/movies/domain/usecases/get_popular_movies_usecase.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;

  MoviesBloc(
    this.getNowPlayingMoviesUseCase,
    this.getPopularMoviesUseCase,
    this.getTopRatedMoviesUseCase,
  ) : super(const MoviesState()) {
    on<GetNowPlayingEvent>(_getNowPlayingMovies);
    on<GetPopularEvent>(_getPopularMovies);
    on<GetTopRatedEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getNowPlayingMovies(
      GetNowPlayingEvent event, Emitter<MoviesState> emit) async {
    final result = await getNowPlayingMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
            nowPlayingState: RequestState.error, nowPlayingMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(
            nowPlayingMovies: r, nowPlayingState: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getPopularMovies(
      GetPopularEvent event, Emitter<MoviesState> emit) async {
    final result = await getPopularMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
            popularState: RequestState.error, popularMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(popularMovies: r, popularState: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedEvent event, Emitter<MoviesState> emit) async {
    final result = await getTopRatedMoviesUseCase(const NoParameters());
    result.fold(
      (l) => emit(
        state.copyWith(
            topRatedState: RequestState.error, topRatedMessage: l.message),
      ),
      (r) => emit(
        state.copyWith(topRatedMovies: r, topRatedState: RequestState.loaded),
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:final_project/bloc/movie/movie_event.dart';
import 'package:final_project/bloc/movie/movie_state.dart';

import '../../datasource/token_local_data_source.dart';
import '../../models/movie.dart';
import '../../models/session.dart';
import '../../repository/moveis_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{

  final TokenLocalDatasource _tokenLocalDatasource = TokenLocalDatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();

  MovieBloc():super(MovieInitial()){
    on<GetMoviesEvent>(_getMovies);
    on<GetMovieWithSessions>(_getMovieWithSessions);

  }

  void _getMovies(GetMoviesEvent event, Emitter<MovieState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(MovieFailure());
    } else {
      String date = '${event.date.year}-${event.date.month}-${event.date.day}';
      final moviesBody = await _movieRepository.getAllMoviesDate(
          accessToken, date);
      if (moviesBody["success"] == false) {
        emit(MovieFailure());
      } else {
        List<Movie> movies = [];
        for (int i = 0; i < moviesBody["data"].length; i++) {
          movies.add(Movie.fromJson(moviesBody["data"][i]));
        }
        movies.sort((a, b) => b.rating.compareTo(a.rating));

        emit(MovieSuccessful(movies: movies, date: event.date));
        print(state);
      }
    }
  }

  void _getMovieWithSessions(GetMovieWithSessions event, Emitter<MovieState> state) async{
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(MovieFailure());
    } else {
      String date = '${event.date.year}-${event.date.month}-${event.date.day}';
      final sessionsBody = await _movieRepository.getSessionsMovieDate(accessToken, date, event.movie.id);
      if (sessionsBody["success"] == false) {
        emit(MovieFailure());
      } else {
        final sessionsApi = sessionsBody["data"];
        print(sessionsApi);
        List<Session> sessions = [];
        for (int i = 0; i < sessionsApi.length; i++) {
          sessions.add(Session.fromJson(sessionsApi[i]));
        }
        sessions = sessions.where((element) => element.date.isAfter(DateTime.now())).toList();
        sessions.sort((a, b)=>a.date.compareTo(b.date));
        emit(MovieSuccessfulWithSessions(movie: event.movie, sessions: sessions));

      }
    }
  }


}
import 'package:bloc/bloc.dart';
import 'package:final_project/data/datasource/token_local_data_source.dart';
import 'package:final_project/data/repository/moveis_repository.dart';
import 'package:final_project/features/movies/bloc/movie/movie_event.dart';
import 'package:final_project/features/movies/bloc/movie/movie_state.dart';
import 'package:final_project/features/movies/models/movie.dart';
import 'package:final_project/features/session/models/session.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final DataSource _tokenLocalDatasource = DatasourceImpl();
  final MovieRepository _movieRepository = MovieRepository();

  MovieBloc() : super(MovieInitial()) {
    on<GetMoviesEvent>(_getMovies);
    on<GetMovieWithSessions>(_getMovieWithSessions);
  }

  void _getMovies(GetMoviesEvent event, Emitter<MovieState> emit) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(MovieFailure(error: "Account error"));
    } else {
      String date = '${event.date.year}-${event.date.month}-${event.date.day}';
      final moviesBody =
          await _movieRepository.getAllMoviesDate(accessToken, date);
      if (moviesBody["success"] == false) {
        emit(MovieFailure(error: moviesBody["data"]));
      } else {
        List<Movie> movies = [];
        for (int i = 0; i < moviesBody["data"].length; i++) {
          movies.add(Movie.fromJson(moviesBody["data"][i]));
        }
        movies.sort((a, b) => b.rating.compareTo(a.rating));

        emit(MovieSuccessful(movies: movies, date: event.date));
      }
    }
  }

  void _getMovieWithSessions(
      GetMovieWithSessions event, Emitter<MovieState> state) async {
    final accessToken = await _tokenLocalDatasource.getToken();
    if (accessToken == null) {
      emit(MovieFailure(error: "Account error"));
    } else {
      String date = '${event.date.year}-${event.date.month}-${event.date.day}';
      final sessionsBody = await _movieRepository.getSessionsMovieDate(
          accessToken, date, event.movie.id);
      if (sessionsBody["success"] == false) {
        emit(MovieFailure(error: sessionsBody["data"]));
      } else {
        final sessionsApi = sessionsBody["data"];
        List<Session> sessions = [];
        for (int i = 0; i < sessionsApi.length; i++) {
          sessions.add(Session.fromJson(sessionsApi[i]));
        }
        print(DateTime.now());
        sessions = sessions
            .where((element) => element.date.isAfter(DateTime.now()))
            .toList();
        sessions.sort((a, b) => a.date.compareTo(b.date));
        emit(MovieSuccessfulWithSessions(
            movie: event.movie, sessions: sessions));
      }
    }
  }
}
